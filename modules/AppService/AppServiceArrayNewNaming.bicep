/*
Builds multiple App Services using Bicep/ARM
Reference: https://docs.microsoft.com/en-us/azure/templates/microsoft.web/2021-01-15/sites?tabs=bicep
*/

@description('Resource location - from Resource Group')
param location string = resourceGroup().location

@description('Tags - with defaults')
param tags object 
//param appProperties object ={}
param siteConfig object = {}

@description('App Service Array')
param appsArray array = []

@description('App Service Plan ID')
param serverFarmId string

param virtualNetworkSubnetId string
param logAnalyticsWorkspaceId string

//App Service 
@batchSize(1)
resource webApplicationResources 'Microsoft.Web/sites@2021-01-15' = [ for i in range(0, length(appsArray)) : {
  name: '${appsArray[i].appName}'
  location: location
  tags:tags
  properties: {
    serverFarmId: serverFarmId
    httpsOnly:true
    virtualNetworkSubnetId:virtualNetworkSubnetId
    hostNamesDisabled: false
    // hostNameSslStates: appsArray[i].customDomain ? [
    //   {
    //     name: appsArray[i].appDomainName
    //     sslState: 'SniEnabled'
    //     thumbprint: appsArray[i].customDomainSslThumbprint
    //     hostType: 'Standard'
    //   }
    //   {
    //     name: '${appsArray[i].appNameShort}.azurewebsites.net'
    //     sslState: 'Disabled'
    //     hostType: 'Standard'
    //   }
    //   {
    //     name: '${appsArray[i].appNameShort}.scm.azurewebsites.net'
    //     sslState: 'Disabled'
    //     hostType: 'Repository'
    //   }

    // ] : [] 
  }
  identity: {
     type: 'SystemAssigned'
  }
}]

// @batchSize(1)
// resource appServiceLogging 'Microsoft.Web/sites/config@2020-06-01' =[ for i in range(0, length(appsArray)) : {
//   name: '${webApplicationResources[i].name}/logs'
//   properties: {
//     applicationLogs: {
//       fileSystem: {
//         level: 'Warning'
//       }
//     }
//     httpLogs: {
//       fileSystem: {
//         retentionInMb: 40
//         enabled: true
//       }
//     }
//     failedRequestsTracing: {
//       enabled: true
//     }
//     detailedErrorMessages: {
//       enabled: true
//     }
//   }
//   dependsOn: [
//     webApplicationResources
//     // appServiceSiteExtension
//   ]
// }]

@batchSize(1)
module appSettings 'appsettings.bicep' = [ for i in range(0, length(appsArray)) : {
  name: '${webApplicationResources[i].name}-appsettings'
  params: {
    appname:webApplicationResources[i].name
    // Get the current appsettings
    currentAppSettings: list(resourceId('Microsoft.Web/sites/config',webApplicationResources[i].name, 'appsettings'), '2022-03-01').properties
    appSettings: {
      APPINSIGHTS_INSTRUMENTATIONKEY: appInsights[i].properties.InstrumentationKey
      APPLICATIONINSIGHTS_CONNECTION_STRING: appInsights[i].properties.ConnectionString
      WEBSITE_TIME_ZONE: 'AUS Eastern Standard Time'
    }
  }
  dependsOn:[
    webApplicationResources
    appInsights
  ]
}]



/* resource appServiceAppSettings 'Microsoft.Web/sites/config@2020-06-01' = [ for i in range(0, length(appsArray)) : {
  name: '${webApplicationResources[i].name}/appsettings'
  properties: {
    APPINSIGHTS_INSTRUMENTATIONKEY: appInsights[i].properties.InstrumentationKey
    APPLICATIONINSIGHTS_CONNECTION_STRING: appInsights[i].properties.ConnectionString
  }
  dependsOn: [
    webApplicationResources
    appInsights
    // appServiceSiteExtension
  ]
}] */

@batchSize(1)
resource appServiceConfig 'Microsoft.Web/sites/config@2020-06-01' = [ for i in range(0, length(appsArray)) : {
  parent: webApplicationResources[i]
  name: 'web'
  properties: {
   vnetRouteAllEnabled:true
   http20Enabled: siteConfig.http20Enabled
   minTlsVersion: siteConfig.minTlsVersion
   ipSecurityRestrictions: siteConfig.ipSecurityRestrictions
  }
  dependsOn: [
    webApplicationResources
    appInsights
    // appServiceSiteExtension
  ]
}]


// resource appServiceSiteExtension 'Microsoft.Web/sites/siteextensions@2020-06-01' = [ for i in range(0, length(appsArray)) :  {
//   name: '${webApplicationResources[i].name}/Microsoft.ApplicationInsights.AzureWebsites'
//   dependsOn: [
//     appInsights
//   ]
// }]

resource appInsights 'microsoft.insights/components@2020-02-02-preview' = [ for i in range(0, length(appsArray)) :  {
  name: '${webApplicationResources[i].name}-ai'
  location: location
  kind: 'string'
  tags: tags
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspaceId
  }
  dependsOn: [
    webApplicationResources
    // appServiceSiteExtension
  ]
}]
