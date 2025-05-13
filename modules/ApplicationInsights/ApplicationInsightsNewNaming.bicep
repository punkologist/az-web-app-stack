
@description('Resource location - from Resource Group')
param location string = resourceGroup().location

@description('App Name')
param appName string = ''

@description('Tags - with defaults')
param tags object = {
  BuiltBy:'daniel.mitchell@company.com.au'
  Version:'0.1'
  Description:'Azure Web Stack Test'
  Environment: 'Test'
}

resource AppInsights_webSiteName 'Microsoft.Insights/components@2018-05-01-preview' = {
  name: '${appName}-Ai'
  location: location
  tags:tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

output appInsights object = AppInsights_webSiteName
