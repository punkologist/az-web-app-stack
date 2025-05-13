/*
Builds a App Service using Bicep/ARM
Reference: https://docs.microsoft.com/en-us/azure/templates/microsoft.web/2021-01-15/sites?tabs=bicep
*/

@description('Resource location - from Resource Group')
param location string = resourceGroup().location

@description('Tags - with defaults')
param tags object = {
  BuiltBy:'daniel.mitchell@company.com.au'
  Version:'0.1'
  Description:'Azure Web Stack Test'
  Environment: 'Test'
}

//param appProperties object ={}
param siteConfig object = {}

@description('App Name')
param appName string

@description('App Service Plan ID')
param serverFarmId string

@description('Log Analytics Workspace Id')
param logAnalyticsWorkspaceId string


var appInsightName = 'ai-${appName}'

//App Service 
resource appService 'Microsoft.Web/sites@2021-01-15' = {
  name: appName
  location: location
  tags:tags
  properties: {
    serverFarmId: serverFarmId
    siteConfig: siteConfig
  }
  identity: {
     type: 'SystemAssigned'
  }
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightName
  location: location
  kind: 'string'
  tags: {
    displayName: 'AppInsight'
    ProjectName: appName
  }
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspaceId
  }
}

// resource AppInsights_webSiteName 'Microsoft.Insights/components@2018-05-01-preview' = {
//   name: 'AppInsights${webapp.name}'
//   location: location
//   tags: {
//     'hidden-link:${webapp.id}': 'Resource'
//     displayName: 'AppInsightsComponent'
//   }
//   kind: 'web'
//   properties: {
//     Application_Type: 'web'
//     WorkspaceResourceId: logAnalyticsWorkspaceId
//   }
// }

resource appServiceLogging 'Microsoft.Web/sites/config@2020-06-01' = {
  parent: appService
  name: 'appsettings'
  properties: {
    APPINSIGHTS_INSTRUMENTATIONKEY: appInsights.properties.InstrumentationKey
  }
  
}


resource appServiceAppSettings 'Microsoft.Web/sites/config@2020-06-01' = {
  parent: appService
  name: 'logs'
  properties: {
    applicationLogs: {
      fileSystem: {
        level: 'Warning'
      }
    }
    httpLogs: {
      fileSystem: {
        retentionInMb: 40
        enabled: true
      }
    }
    failedRequestsTracing: {
      enabled: true
    }
    detailedErrorMessages: {
      enabled: true
    }
  }
}


