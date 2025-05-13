
param tags object 
param appsVirtualNetworkName string
param appsVirtualNetworkRgName string
param appsSubnetNames array
//location
param location string = resourceGroup().location
param mongoLocation string = 'Australia East'

//SQL Vars
param sqlAdministratorLogin string
@secure()
param sqlAdministratorLoginPassword string
param publicIpAddressName string
param publicIpAddressDnsName string
param publicIpAddressSku string
param publicIpAddressAllocationType string
param webAppPlanName string
param webAppPlanSku string
param sslCertificates array
param sqlServerName string
param sqlDatabases array
param logAnalyticsWorkspaceName string
@description('Web App Services Array')
param appsArray array
param mongoDatabases array
param mongoDbAccountName string
param functionAppPlanName string
param functionApps array
param functionAppStorageAccountName string
param publicIpResourceName string
param appServicePlanSkuCapacity int
param appSvcPlanKind string
param userAssignedIdentityId string
param elasticPoolSku object
param appGatewayParams object
param customDomainVerificationId string

resource appSubnets 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' existing =  [for subnetName in appsSubnetNames: {
  name : '${appsVirtualNetworkName}/${subnetName}'
  scope:resourceGroup(appsVirtualNetworkRgName)
}]

/* resource hubSubnets 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' existing =  [for subnetName in hubSubnetNames: {
  name : '${hubVirtualNetworkName}/${subnetName}'
}] */

resource applyTags 'Microsoft.Resources/tags@2021-04-01' = {
  name: 'default'
  scope: resourceGroup()
  properties: {
    tags: tags
  }
}

//Public IP  - Module
module publicIpAddress 'modules/PublicIPAddress/PublicIPAddress.bicep' = {
  name: publicIpAddressName
  params: {
    location: location
    tags: tags
    domainNameLabel: toLower(publicIpAddressDnsName)
    publicIpAddressSku:publicIpAddressSku
    publicIpAddressAllocationType: publicIpAddressAllocationType
    publicIpResourceName:publicIpResourceName
  }
}

//App Service Plan - Module
module appServicePlan 'modules/AppServicePlan/AppServicePlan.bicep' = {
  name: webAppPlanName
  params: {
    location: location
    tags: tags
    skuName: webAppPlanSku
    skuCapacity:appServicePlanSkuCapacity
    appSvcPlanKind:appSvcPlanKind
    appServicePlanName:webAppPlanName
  }
}

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-03-01-preview' = {
  name: logAnalyticsWorkspaceName
  location: location
  tags:tags
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 120
  }
}


module appService 'modules/AppService/AppServiceArray.bicep' ={
   name:'webApps'
 params: {
  logAnalyticsWorkspaceId:logAnalyticsWorkspace.id
  customDomainVerificationId:customDomainVerificationId
  userAssignedIdentityId:userAssignedIdentityId
    serverFarmId:appServicePlan.outputs.app_plan_id
     location: location
      appsArray:appsArray
      virtualNetworkSubnetId:appSubnets[0].id
       siteConfig:{
               http20Enabled: true
              minTlsVersion: '1.2'
               ipSecurityRestrictions: [
                 {
                  vnetSubnetResourceId: appSubnets[3].id
                 action: 'Allow'
                  tag: 'Default'
                  priority: 100
                  name: 'GatewaySubnet'
                  description: 'Isolate traffic to subnet containing Azure Application Gateway'
                }
               ] 
             }
              tags:tags

 }
}

module storageAccount 'modules/StorageAccount/StorageAccount.bicep'  = {
  name:'storageaccount'
  params:{
    location:location
    storageAccountName:functionAppStorageAccountName
    tags:tags
  }
}

module functionAppServicePlan 'modules/AppServicePlan/AppServicePlan.bicep' = {
  name: functionAppPlanName
  params: {
    appServicePlanName:functionAppPlanName
    location: location
    tags: tags
    skuName: webAppPlanSku
    appSvcPlanKind:'FunctionApp'
    skuCapacity:1
  }
}


module functionAppResources 'modules/FunctionApp/FunctionApp.bicep' = {
  name: 'functionapps'
  params:{
    tags:tags
    location: location
    appServiceId:functionAppServicePlan.outputs.app_plan_id
    functionApps:functionApps
    logAnalyticsWorkspaceId:logAnalyticsWorkspace.id
    storageAccountName:storageAccount.outputs.accountName
    storageAccountKey:storageAccount.outputs.accountKey
    virtualNetworkSubnetId:appSubnets[2].id
  }
}




//Azure SQL SQL
module sqlServer 'modules/AzureSQL/AzureSQL.bicep' = {
  name: 'sql'
  params: {
    location: location
    tags: tags
    sqlAdministratorLogin: sqlAdministratorLogin
    sqlAdministratorLoginPassword: sqlAdministratorLoginPassword
    sqlServerName:sqlServerName
    sqlDatabases:sqlDatabases
    elasticPoolSku: elasticPoolSku
  }
}

module mongoDbs 'modules/MongoDb/mongo.bicep' ={
  name:'mongo'
  params:{
    tags:tags
    location:mongoLocation
    mongoDatabases:mongoDatabases
    mongoDbAccountName:mongoDbAccountName
    appsVirtualNetworkName:appsVirtualNetworkName
    appsVirtualNetworkRgName:appsVirtualNetworkRgName
    appsSubnetNames:appsSubnetNames
  }
}


//Application Gateway - Module
module appGateway 'modules/ApplicationGateway/ApplicationGatewayV2.bicep' = {
  name: 'appgateway'
  params: {
    userAssignedIdentityId:userAssignedIdentityId
    location: location
    tags: tags
    applicationGatewayName: appGatewayParams.applicationGatewayName
    sku_name:appGatewayParams.applicationGatewaySkuSize
    sku_tier:appGatewayParams.applicationGatewayTier
    sslCertificates: sslCertificates
    firewallPolicyName:appGatewayParams.firewallPolicyName
    // trustedRootCertificates: trustedRootCertificates
    gatewayIPConfigurations: [
      {
        name: appGatewayParams.appGwIpConfigName
        properties: {
          subnet: {
            id: appSubnets[3].id
          }
        }
      }
    ]

    frontendIPConfigurations: [
      {
        name: appGatewayParams.appGwFrontendIpConfigName
        properties: {
          publicIPAddress: {
            id: publicIpAddress.outputs.pip_id
          }
        }
      }
      appGatewayParams.privateIpConfig
    ]
    frontendPorts: [
      {
        name: appGatewayParams.appGwFrontendPortNameHttp
        properties: {
          port: appGatewayParams.appGwFrontendPortHttp
        }
      }
      {
        name: appGatewayParams.appGwFrontendPortNameHttps
        properties: {
          port: appGatewayParams.appGwFrontendPortHttps
        }
      }
    ]

    backendAddressPools:appGatewayParams.backendPools
    backendHttpSettingsCollection: appGatewayParams.backendHttpSettingsCollection
    httpListeners: appGatewayParams.httpListeners
    requestRoutingRules: appGatewayParams.requestRoutingRules
    redirectConfigurations:appGatewayParams.redirectConfigurations
   
    probes: appGatewayParams.appGatewayProbes
  }
  dependsOn: [
    appService
    functionAppResources
    sqlServer
    mongoDbs
  ]
}
