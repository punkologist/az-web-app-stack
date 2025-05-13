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

param customDomainVerificationId string
param userAssignedIdentityId string

param virtualNetworkSubnetId string
param logAnalyticsWorkspaceId string


var customDomainApps = filter(appsArray, app => app.customDomain == true)
var nonCustomDomainApps = filter(appsArray, app => app.customDomain == false)

//App Service (custom domain)
@batchSize(1)
resource webApplicationResources 'Microsoft.Web/sites@2021-01-15' = [ for i in range(0, length(customDomainApps)) : {
  name: '${customDomainApps[i].appNamePrefix}-${uniqueString(resourceGroup().id)}'
  location: location
  tags:tags
  identity:{
    type: 'SystemAssigned, UserAssigned'
    userAssignedIdentities: {
      '${userAssignedIdentityId}': {}
    }
  }
  properties: {
    serverFarmId: serverFarmId
    httpsOnly:true
    virtualNetworkSubnetId:virtualNetworkSubnetId
    hostNamesDisabled: false
    hostNameSslStates: [
      {
        name: customDomainApps[i].appDomainName
        sslState: 'SniEnabled'
        thumbprint: customDomainApps[i].customDomainSslThumbprint
        hostType: 'Standard'
      }
      {
        name: '${customDomainApps[i].appNamePrefix}-${uniqueString(resourceGroup().id)}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${customDomainApps[i].appNamePrefix}-${uniqueString(resourceGroup().id)}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }

    ]
    customDomainVerificationId:customDomainVerificationId
  }
}]



@batchSize(1)
resource hostNameBindings 'Microsoft.Web/sites/hostNameBindings@2024-04-01' = [ for i in range(0, length(customDomainApps)) : {
  parent: webApplicationResources[i]
  name: customDomainApps[i].appDomainName
  properties: {
    siteName: '${customDomainApps[i].appNamePrefix}-${uniqueString(resourceGroup().id)}'
    hostNameType: 'Verified'
    sslState: 'SniEnabled'
    thumbprint: customDomainApps[i].customDomainSslThumbprint
  } 
}]

@batchSize(1)
module appSettings 'appsettings.bicep' = [ for i in range(0, length(customDomainApps)) : {
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


@batchSize(1)
resource appServiceConfig 'Microsoft.Web/sites/config@2020-06-01' = [ for i in range(0, length(customDomainApps)) : {
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


resource appInsights 'microsoft.insights/components@2020-02-02-preview' = [ for i in range(0, length(customDomainApps)) :  {
  name: 'ai-${webApplicationResources[i].name}'
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

//App Service (non custom domain)
@batchSize(1)
resource webApplicationResourcesnc 'Microsoft.Web/sites@2021-01-15' = [ for i in range(0, length(nonCustomDomainApps)) : {
  name: '${nonCustomDomainApps[i].appNamePrefix}-${uniqueString(resourceGroup().id)}'
  location: location
  tags:tags
  identity:{
    type: 'SystemAssigned, UserAssigned'
    userAssignedIdentities: {
      '${userAssignedIdentityId}': {}
    }
  }
  properties: {
    serverFarmId: serverFarmId
    httpsOnly:true
    virtualNetworkSubnetId:virtualNetworkSubnetId
    hostNamesDisabled: false
    customDomainVerificationId:customDomainVerificationId
  }
}]


@batchSize(1)
module appSettingsnc 'appsettings.bicep' = [ for i in range(0, length(nonCustomDomainApps)) : {
  name: '${webApplicationResourcesnc[i].name}-appsettings'
  params: {
    appname:webApplicationResourcesnc[i].name
    // Get the current appsettings
    currentAppSettings: list(resourceId('Microsoft.Web/sites/config',webApplicationResourcesnc[i].name, 'appsettings'), '2022-03-01').properties
    appSettings: {
      APPINSIGHTS_INSTRUMENTATIONKEY: appInsightsnc[i].properties.InstrumentationKey
      APPLICATIONINSIGHTS_CONNECTION_STRING: appInsightsnc[i].properties.ConnectionString
      WEBSITE_TIME_ZONE: 'AUS Eastern Standard Time'
    }
  }
  dependsOn:[
    webApplicationResourcesnc
    appInsightsnc
  ]
}]


@batchSize(1)
resource appServiceConfignc 'Microsoft.Web/sites/config@2020-06-01' = [ for i in range(0, length(nonCustomDomainApps)) : {
  parent: webApplicationResourcesnc[i]
  name: 'web'
  properties: {
   vnetRouteAllEnabled:true
   http20Enabled: siteConfig.http20Enabled
   minTlsVersion: siteConfig.minTlsVersion
   ipSecurityRestrictions: siteConfig.ipSecurityRestrictions
  }
  dependsOn: [
    webApplicationResourcesnc
    appInsightsnc
    // appServiceSiteExtension
  ]
}]


resource appInsightsnc 'microsoft.insights/components@2020-02-02-preview' = [ for i in range(0, length(nonCustomDomainApps)) :  {
  name: 'ai-${webApplicationResourcesnc[i].name}'
  location: location
  kind: 'string'
  tags: tags
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspaceId
  }
  dependsOn: [
    webApplicationResourcesnc
    // appServiceSiteExtension
  ]
}]
