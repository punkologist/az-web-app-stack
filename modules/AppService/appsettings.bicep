param appname string
param appSettings object
param currentAppSettings object

resource appServiceAppSettings 'Microsoft.Web/sites/config@2020-06-01' = {
  name: '${appname}/appsettings'
  properties: union(currentAppSettings, appSettings)
 
}
