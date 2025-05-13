@description('Web App Services Array')
param appsArray array
param functionAppsArray array
param applicationGatewayName string
param appGwHttpSettingNameHttp string
param appGwHttpSettingNameHttps string
param appGwFrontendPortNameHttp string
param appGwFrontendPortNameHttps string
param appGwFrontendIpConfigName string
param appGwPrivateIpConfigName string

var appGwFrontendPortIdHttp = resourceId('Microsoft.Network/applicationGateways/frontendPorts/', applicationGatewayName, appGwFrontendPortNameHttp)
var appGwFrontendPortIdHttps = resourceId('Microsoft.Network/applicationGateways/frontendPorts/', applicationGatewayName, appGwFrontendPortNameHttps)
var appGwFrontendIpConfigId = resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations/', applicationGatewayName, appGwFrontendIpConfigName)
var appGwPrivateFrontendIpConfigId = resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations/', applicationGatewayName, appGwPrivateIpConfigName)



var httpListeners = [for (app,i) in appsArray:{
  name: 'listenerHttp-${app.appNameShort}'
  properties: {
    frontendIPConfiguration: {
      id: app.private ? appGwPrivateFrontendIpConfigId : appGwFrontendIpConfigId 
    }
    frontendPort: {
      id: appGwFrontendPortIdHttp
    }
    protocol: 'Http'
    hostName: '${app.appDomainName}'
  }
}]

var httpsListeners = [for (app,i) in appsArray:{
  name: 'listenerHttps-${app.appNameShort}'
  properties: {
    frontendIPConfiguration: {
      id: app.private ? appGwPrivateFrontendIpConfigId : appGwFrontendIpConfigId 
    }
    frontendPort: {
      id: appGwFrontendPortIdHttps
    }
    protocol: 'Https'
    hostName: '${app.appDomainName}'
    sslCertificate: {
      id: resourceId('Microsoft.Network/applicationGateways/sslCertificates',applicationGatewayName,'${app.sslCertName}')
    }
  }
}]

var fnHttpsListeners = [for (app,i) in functionAppsArray:{
  name: 'listenerHttps-${app.appNameShort}'
  properties: {
    frontendIPConfiguration: {
      id: appGwFrontendIpConfigId
    }
    frontendPort: {
      id: appGwFrontendPortIdHttps
    }
    protocol: 'Https'
    hostName: '${app.appDomainName}'
    sslCertificate: {
      id: resourceId('Microsoft.Network/applicationGateways/sslCertificates',applicationGatewayName,'${app.sslCertName}')
    }
  }
}]


var httpRoutingRules = [for (app,i) in appsArray:{
  name: 'rrHttp-${app.appNameShort}'
  properties: {
    priority: i+1
    ruleType: 'Basic'
    httpListener: {
      id: resourceId('Microsoft.Network/applicationGateways/httpListeners/', applicationGatewayName, 'listenerHttp-${app.appNameShort}')
    }
    redirectConfiguration: {
      id:resourceId('Microsoft.Network/applicationGateways/redirectConfigurations/', applicationGatewayName, 'rdc-${app.appNameShort}')  
    }
      
}

}]

var httpsRoutingRules = [for (app,i) in appsArray:{
  name: 'rrHttps-${app.appNameShort}'
  properties: {
    priority: i+100
    ruleType: 'Basic'
    httpListener: {
      id: resourceId('Microsoft.Network/applicationGateways/httpListeners/', applicationGatewayName, 'listenerHttps-${app.appNameShort}')
    }
    backendAddressPool: {
      id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools/', applicationGatewayName, 'beap-${app.appNameShort}')
    }
    backendHttpSettings: {
      id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection/', applicationGatewayName, app.backendSettingName)
    }
}

}]

var fnHttpsRoutingRules = [for (app,i) in functionAppsArray:{
  name: 'rrHttps-${app.appNameShort}'
  properties: {
    priority: i+300
    ruleType: 'Basic'
    httpListener: {
      id: resourceId('Microsoft.Network/applicationGateways/httpListeners/', applicationGatewayName, 'listenerHttps-${app.appNameShort}')
    }
    backendAddressPool: {
      id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools/', applicationGatewayName, 'beap-${app.appNameShort}')
    }
    backendHttpSettings: {
     id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection/', applicationGatewayName, app.backendSettingName)
    }
}

}]

var webbackendPools = [for (app,i) in appsArray:{
  name: 'beap-${app.appNameShort}'
  properties: {
    backendAddresses: [
      {
            fqdn: app.backendAddress
      }
    ]
  }
}]

var fnBackendPools = [for (app,i) in functionAppsArray:{
  name: 'beap-${app.appNameShort}'
  properties: {
    backendAddresses: [
      {
            fqdn: app.backendAddress
      }
    ]
  }
}]

var redirectConfigurations = [for (app,i) in appsArray:{
      name: 'rdc-${app.appNameShort}'
      properties: {
          redirectType: 'Permanent'
          targetListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners/', applicationGatewayName, 'listenerHttps-${app.appNameShort}')
          }
          includePath: true
          includeQueryString: true
          requestRoutingRules: [
              {
                  id: resourceId('Microsoft.Network/applicationGateways/requestRoutingRules/', applicationGatewayName, 'rrHttp-${app.appNameShort}')
              }
          ]
      }
  }]

  var wwwRedirectsFilter = [for (item, i) in appsArray:item.wwwRedirectListener == true ? item : []]
  var wwwRedirects = intersection(wwwRedirectsFilter,appsArray)
  
  var httpWwwRedirectsListeners = [for (app,i) in wwwRedirects:{
    name: 'listenerHttpWww-${app.appNameShort}'
    properties: {
      frontendIPConfiguration: {
        id: app.private ? appGwPrivateFrontendIpConfigId : appGwFrontendIpConfigId 
      }
      frontendPort: {
        id: appGwFrontendPortIdHttp
      }
      protocol: 'Http'
      hostName: 'www.${app.appDomainName}'
    }
  }]

  var httpsWwwRedirectsListeners = [for (app,i) in wwwRedirects:{
    name: 'listenerHttpsWww-${app.appNameShort}'
    properties: {
      frontendIPConfiguration: {
        id: app.private ? appGwPrivateFrontendIpConfigId : appGwFrontendIpConfigId 
      }
      frontendPort: {
        id: appGwFrontendPortIdHttps
      }
      protocol: 'Https'
      hostName: 'www.${app.appDomainName}'
      sslCertificate: {
        id: resourceId('Microsoft.Network/applicationGateways/sslCertificates',applicationGatewayName,'${app.sslCertName}')
      }
    }
  }]

  var httpWwwRedirectsRoutingRules = [for (app,i) in wwwRedirects:{
    name: 'rrHttpWww-${app.appNameShort}'
    properties: {
      priority: i+400
      ruleType: 'Basic'
      httpListener: {
        id: resourceId('Microsoft.Network/applicationGateways/httpListeners/', applicationGatewayName, 'listenerHttpWww-${app.appNameShort}')
      }
      redirectConfiguration: {
        id:resourceId('Microsoft.Network/applicationGateways/redirectConfigurations/', applicationGatewayName, 'rdcWwwHttp-${app.appNameShort}')  
      }
        
  }
  
  }]
  

  var httpsWwwRedirectsRoutingRules = [for (app,i) in wwwRedirects:{
    name: 'rrHttpsWww-${app.appNameShort}'
    properties: {
      priority: i+500
      ruleType: 'Basic'
      httpListener: {
        id: resourceId('Microsoft.Network/applicationGateways/httpListeners/', applicationGatewayName, 'listenerHttpsWww-${app.appNameShort}')
      }
      redirectConfiguration: {
        id:resourceId('Microsoft.Network/applicationGateways/redirectConfigurations/', applicationGatewayName, 'rdcWwwHttps-${app.appNameShort}')  
      }
        
  }
  
  }]

  var redirectWwwRedirectsHttpConfigurations = [for (app,i) in wwwRedirects:{
    name: 'rdcWwwHttp-${app.appNameShort}'
    properties: {
        redirectType: 'Permanent'
        targetListener: {
          id: resourceId('Microsoft.Network/applicationGateways/httpListeners/', applicationGatewayName, 'listenerHttps-${app.appNameShort}')
        }
        includePath: true
        includeQueryString: true
        requestRoutingRules: [
            {
                id: resourceId('Microsoft.Network/applicationGateways/requestRoutingRules/', applicationGatewayName, 'rrHttpWww-${app.appNameShort}')
            }
        ]
    }
}]
 

var redirectWwwRedirectsHttpsConfigurations = [for (app,i) in wwwRedirects:{
  name: 'rdcWwwHttps-${app.appNameShort}'
  properties: {
      redirectType: 'Permanent'
      targetListener: {
        id: resourceId('Microsoft.Network/applicationGateways/httpListeners/', applicationGatewayName, 'listenerHttps-${app.appNameShort}')
      }
      includePath: true
      includeQueryString: true
      requestRoutingRules: [
          {
              id: resourceId('Microsoft.Network/applicationGateways/requestRoutingRules/', applicationGatewayName, 'rrHttpsWww-${app.appNameShort}')
          }
      ]
  }
}]

  var customDomainApps = [for (item, i) in appsArray:item.customDomain == true ? item : []]
  var filteredCustomDomainApps = intersection(customDomainApps,appsArray)

  var customBackendSettings = [for (app,i) in filteredCustomDomainApps:{
    name: app.backendSettingName
    properties: {
      port: 443
      protocol: 'Https'
      cookieBasedAffinity: 'Disabled'
      requestTimeout: 180
      pickHostNameFromBackendAddress: false
      probe: {
        id: resourceId('Microsoft.Network/applicationGateways/probes/', applicationGatewayName, '${app.appNameShort}-probe')
      }
    }
  }]


  var defaultbackendSettings = [
    {
      name: appGwHttpSettingNameHttp
      properties: {
        port: 80
        protocol: 'Http'
        cookieBasedAffinity: 'Disabled'
        requestTimeout: 180
        pickHostNameFromBackendAddress: true
        }
    }
    {
      name: appGwHttpSettingNameHttps
      properties: {
        port: 443
        protocol: 'Https'
        cookieBasedAffinity: 'Disabled'
        requestTimeout: 180
        pickHostNameFromBackendAddress: true
      }
    }
   
  ]

  var backendSettings = concat(defaultbackendSettings,customBackendSettings)


  var customProbes =  [for (app,i) in filteredCustomDomainApps:{
    name: '${app.appNameShort}-probe'
    properties:{
      protocol: 'Https'
      host: app.appDomainName
      path:app.customProbePath
      interval:30
      timeout:180
      unhealthyThreshold:3
      pickHostNameFromBackendHttpSettings: false
      minServers:0
      match:app.customProbeMatch
    }
  }]

  var defaultprobes = [
    {
      name:'appGatewayHttpSettingProbe_443'
      properties:{
        protocol: 'Https'
        path:'/'
        interval:30
        timeout:30
        unhealthyThreshold:3
        pickHostNameFromBackendHttpSettings: true
        minServers:0
      }
    }
  ]

  var probes = concat(defaultprobes,customProbes)

  var allListeners = concat(httpListeners,httpsListeners, fnHttpsListeners, httpWwwRedirectsListeners, httpsWwwRedirectsListeners)
  var allRoutingRules = concat(httpRoutingRules,httpsRoutingRules, fnHttpsRoutingRules, httpWwwRedirectsRoutingRules, httpsWwwRedirectsRoutingRules)
  var backendPools = concat(webbackendPools,fnBackendPools)
  var allRedirectConfigurations = concat(redirectConfigurations, redirectWwwRedirectsHttpConfigurations,redirectWwwRedirectsHttpsConfigurations)
   //outputs
  output redirectConfigurations array = allRedirectConfigurations
  output backendSettings array = backendSettings
  output probes array = probes
  output allListeners array = allListeners
  output allRoutingRules array = allRoutingRules
  output backendPools array = backendPools
  output applicationGatewayName string = applicationGatewayName
  output appGwFrontendPortNameHttp string = appGwFrontendPortNameHttp
  output appGwFrontendPortNameHttps string = appGwFrontendPortNameHttps
  output appGwFrontendIpConfigName string = appGwFrontendIpConfigName
