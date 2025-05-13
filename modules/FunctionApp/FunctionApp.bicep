
param location string = resourceGroup().location
param functionApps array
param storageAccountName string
@secure()
param storageAccountKey string
param logAnalyticsWorkspaceId string
param appServiceId string
param virtualNetworkSubnetId string

@description('Tags - with defaults')
param tags object

// App Insights resource
resource appInsights 'Microsoft.Insights/components@2020-02-02-preview' =  [ for i in range(0, length(functionApps)) : {
  name:'ai-${functionApps[i].appNamePrefix}-${uniqueString(resourceGroup().id)}'
   tags:tags
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspaceId
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'

  }
}]

// Function App
@batchSize(1)
resource functionApp 'Microsoft.Web/sites@2020-06-01' = [ for i in range(0, length(functionApps)) : {
  name: '${functionApps[i].appNamePrefix}-${uniqueString(resourceGroup().id)}'
  tags:tags
  location: location
  kind: 'functionapp'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${functionApps[i].appNamePrefix}-${uniqueString(resourceGroup().id)}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${functionApps[i].appNamePrefix}-${uniqueString(resourceGroup().id)}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
    ]
    serverFarmId: appServiceId
    reserved: false
    isXenon: false
    hyperV: false
    siteConfig: {

    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    hostNamesDisabled: false
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    redundancyMode: 'None'
  }
  identity: {
    type: 'SystemAssigned'
 }
}]


@batchSize(1)
module appSettings '../AppService/appsettings.bicep' = [ for i in range(0, length(functionApps)) : {
  name: '${functionApp[i].name}-appsettings'
  params: {
    appname:functionApp[i].name
    // Get the current appsettings
    currentAppSettings: list(resourceId('Microsoft.Web/sites/config',functionApp[i].name, 'appsettings'), '2022-03-01').properties
    appSettings: {
      AzureWebJobsStorage: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storageAccountKey}'
      WEBSITE_CONTENTAZUREFILECONNECTIONSTRING: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storageAccountKey}'
      APPINSIGHTS_INSTRUMENTATIONKEY: appInsights[i].properties.InstrumentationKey
      APPLICATIONINSIGHTS_CONNECTION_STRING: appInsights[i].properties.ConnectionString
      FUNCTIONS_WORKER_RUNTIME: functionApps[i].functionsWorkerRuntime
      FUNCTIONS_EXTENSION_VERSION: functionApps[i].functionsRuntime
      WEBSITE_CONTENTSHARE: toLower(functionApp[i].name)
      WEBSITE_TIME_ZONE: 'AUS Eastern Standard Time'
    }
  }
  dependsOn:[
    functionApp
    appInsights
  ]
}]


// Function App Config
@batchSize(1)
resource functionAppConfig 'Microsoft.Web/sites/config@2020-06-01' =  [ for i in range(0, length(functionApps)) : {
  parent: functionApp[i]
  name: 'web'
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
      'hostingstart.html'
    ]
    netFrameworkVersion: 'v4.0'
    phpVersion: '5.6'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    httpLoggingEnabled: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$${functionApp[i].name}'
    scmType: 'None'
    use32BitWorkerProcess: true
    webSocketsEnabled: false
    alwaysOn: true
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: true
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    cors: {
      allowedOrigins: [
        'https://functions.azure.com'
        'https://functions-staging.azure.com'
        'https://functions-next.azure.com'
      ]
      supportCredentials: false
    }
    localMySqlEnabled: false
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 1
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 1
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: true
    minTlsVersion: '1.2'
    ftpsState: 'AllAllowed'
    preWarmedInstanceCount: 0
    vnetRouteAllEnabled:true
  }
}]

@batchSize(1)
resource functionToSubnet 'Microsoft.Web/sites/networkConfig@2022-03-01' = [ for i in range(0, length(functionApps)) : {
  name: '${functionApp[i].name}/VirtualNetwork'
  properties: {
    subnetResourceId:virtualNetworkSubnetId
  }
  dependsOn:[
    functionApp
  ]
}]

// Function App Binding
@batchSize(1)
resource functionAppBinding 'Microsoft.Web/sites/hostNameBindings@2020-06-01' = [ for i in range(0, length(functionApps)) : {
  parent: functionApp[i]
  name: '${functionApp[i].name}.azurewebsites.net'
  properties: {
    siteName: functionApp[i].name
    hostNameType: 'Verified'
  }
}]


// output resourcesArray array = [ for i in range(0, length(functionApps)-1) :  {
//   name: functionApp[i].name
//   namePrefix: functionApps[i].appNamePrefix
//   id: functionApp[i].id
//   defaultHostname: functionApp[i].properties.defaultHostName
//   outboundIpAddresses: functionApp[i].properties.outboundIpAddresses
//   domainName: functionApps[i].appDomainName
//   sslCertName: functionApps[1].sslCertName
// }]
