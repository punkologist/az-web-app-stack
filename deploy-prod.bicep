var sqlAdministratorLogin = 'dummySqlAdminUser'
var resourceGroupName = 'dummyResourceGroup'
var location = resourceGroup().location
var sqlAdministratorLoginKeyVaultName = 'dummyKeyVaultName'

param gitCommit string
param builtBy string
param version string = '1'
param currentDatetime string = utcNow()
var publicIpAddressName = 'dummyPublicIp-${uniqueString(resourceGroup().id)}'
var appsVirtualNetworkName = 'dummy-vnet'
var appsSubnetNames = [
  'dummySubnet1'
  'dummySubnet2'
  'dummySubnet3'
  'dummySubnet4'
]

var appsVirtualNetworkRgName = 'dummyNetworkRg'
var appGwHttpSettingNameHttps = 'dummyHttpSetting_443'
var appGwHttpSettingNameCustomDomain = 'dummyHttpsSetting_'
var defaultDomainSuffix = '${uniqueString(resourceGroup().id)}.dummy.net'
var kvPitcherComAuName = 'dummy-kv-1'
var kvMyPitcherComAuName = 'dummy-kv-${uniqueString(resourceGroup().id)}'
var kvName = 'dummy-kv-${uniqueString(resourceGroup().id)}'
var myPitcherCertName = 'CERT_dummy.com'
var myPitcherCertKeyVaultSecretName = 'DummyCert'
var pitcherCertName = 'dummy.com-2025'
var pitcherCertKeyVaultSecretName = 'dummycom-2025'
var domainVerificationId = 'DUMMY_VERIFICATION_ID'
var userAssignedIdentitySub = 'dummy-subscription-id'
var userAssignedIdentityName = 'dummy-identity'
var userAssignedIdentityRg = 'dummy-identity-rg'
var vaults_pp_prd_ccert_as_kv_1_externalid = '/subscriptions/dummy-subscription-id/resourceGroups/dummy-rg/providers/microsoft.keyvault/vaults/dummy-kv'
var vaults_pp_prd_ccert_as_kv_1_uri = 'https://dummy-kv.vault.azure.net'

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2024-11-30' existing = {
  name: userAssignedIdentityName
  scope: resourceGroup(userAssignedIdentitySub, userAssignedIdentityRg)
}

resource kvMyPitcherComAu 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: kvMyPitcherComAuName
  scope: resourceGroup(subscription().subscriptionId, resourceGroupName)
}

resource kv 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: kvName
  scope: resourceGroup(subscription().subscriptionId, resourceGroupName)
}

resource pitcherCert 'Microsoft.Web/certificates@2024-04-01' = {
  name: '${resourceGroup().name}-${kvPitcherComAuName}-${pitcherCertKeyVaultSecretName}'
  location: location
  properties: {
    hostNames: [
      '*.dummy.com'
      'dummy.com'
    ]
    keyVaultId: vaults_pp_prd_ccert_as_kv_1_externalid
    keyVaultSecretName: pitcherCertKeyVaultSecretName
  }
}

resource myPitcherCert 'Microsoft.Web/certificates@2024-04-01' = {
  name: '${kvMyPitcherComAuName}-${myPitcherCertKeyVaultSecretName}'
  location: location
  properties: {
    hostNames: [
      '*.dummy.com'
      'dummy.com'
    ]
    keyVaultId: kvMyPitcherComAu.id
    keyVaultSecretName: myPitcherCertKeyVaultSecretName
  }
}

resource appSubnets 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' existing = [for subnetName in appsSubnetNames: {
  name: '${appsVirtualNetworkName}/${subnetName}'
  scope: resourceGroup(appsVirtualNetworkRgName)
}]

var privateIPConfig = {
  name: 'dummyPrivateFrontendIpConfig'
  properties: {
    privateIPAddress: '10.0.0.1'
    privateIPAllocationMethod: 'Static'
    subnet: {
      id: appSubnets[3].id
    }
  }
}

var appsArray = [
  {
    appNamePrefix: 'dummyApp1'
    appDomainName: 'app1.dummy.com'
    sslCertName: pitcherCertName
    backendAddress: 'app1-${defaultDomainSuffix}'
    backendSettingName: '${appGwHttpSettingNameCustomDomain}app1'
    customDomain: true
    customDomainSslThumbprint: pitcherCert.properties.thumbprint
    private: true
    wwwRedirectListener: false
    customProbePath: '/'
    customProbeMatch: {
      statusCodes: [
        '200-399'
        '401'
        '403'
      ]
    }
  }
  // Add more dummy app configurations as needed
]

var functionAppsArray = [
  {
    appNamePrefix: 'dummyFnApp1'
    appDomainName: 'fnapp1.dummy.com'
    sslCertName: pitcherCertName
    functionsRuntime: '~4'
    functionsWorkerRuntime: 'dotnet'
    backendAddress: 'fnapp1-${defaultDomainSuffix}'
    backendSettingName: appGwHttpSettingNameHttps
  }
  // Add more dummy function app configurations as needed
]

module AppGatewayVariables './modules/Variables/AppGatewayVariables.bicep' = {
  name: 'AppGatewayVariables'
  params: {
    appGwHttpSettingNameHttp: 'dummyHttpSetting_80'
    appGwHttpSettingNameHttps: 'dummyHttpSetting_443'
    appGwFrontendIpConfigName: 'dummyFrontendIpConfig'
    appGwFrontendPortNameHttp: 'dummyFrontendPort_80'
    appGwFrontendPortNameHttps: 'dummyFrontendPort_443'
    appGwPrivateIpConfigName: 'dummyPrivateFrontendIpConfig'
    applicationGatewayName: 'dummyAppGateway-${uniqueString(resourceGroup().id)}'
    appsArray: appsArray
    functionAppsArray: functionAppsArray
  }
}

var appGatewayParams = {
  applicationGatewayName: AppGatewayVariables.outputs.applicationGatewayName
  applicationGatewaySkuSize: 'WAF_v2'
  applicationGatewayTier: 'WAF_v2'
  appGwIpConfigName: 'dummyIpConfig'
  appGwFrontendPortNameHttp: AppGatewayVariables.outputs.appGwFrontendPortNameHttp
  appGwFrontendPortHttp: 80
  appGwFrontendPortNameHttps: AppGatewayVariables.outputs.appGwFrontendPortNameHttps
  appGwFrontendPortHttps: 443
  appGwFrontendIpConfigName: AppGatewayVariables.outputs.appGwFrontendIpConfigName
  appGatewayProbes: AppGatewayVariables.outputs.probes
  backendHttpSettingsCollection: AppGatewayVariables.outputs.backendSettings
  backendPools: AppGatewayVariables.outputs.backendPools
  httpListeners: AppGatewayVariables.outputs.allListeners
  redirectConfigurations: AppGatewayVariables.outputs.redirectConfigurations
  requestRoutingRules: AppGatewayVariables.outputs.allRoutingRules
  privateIpConfig: privateIPConfig
  firewallPolicyName: 'dummyWafPolicy-${uniqueString(resourceGroup().id)}'
}

module main 'mainv2.bicep' = {
  name: 'main'
  params: {
    appGatewayParams: appGatewayParams
    userAssignedIdentityId: userAssignedIdentity.id
    customDomainVerificationId: domainVerificationId
    location: location
    functionAppPlanName: 'dummyFunctionAppPlan-${uniqueString(resourceGroup().id)}'
    appsArray: appsArray
    functionApps: functionAppsArray
    functionAppStorageAccountName: 'dummyStorageAccount-${uniqueString(resourceGroup().id)}'
    mongoDatabases: [
      {
        name: 'DUMMY_DB1'
      }
      {
        name: 'DUMMY_DB2'
      }
    ]
    mongoDbAccountName: 'dummyMongoAccount-${uniqueString(resourceGroup().id)}'
    mongoLocation: 'dummyLocation'
    tags: {
      BuiltBy: builtBy
      Commit: gitCommit
      DeploymentName: version
      Description: 'Dummy Azure Web Stack'
      Environment: 'DummyEnvironment'
      LastBuildDateTime: currentDatetime
    }
    appsVirtualNetworkName: appsVirtualNetworkName
    appsVirtualNetworkRgName: appsVirtualNetworkRgName
    appsSubnetNames: appsSubnetNames
    appServicePlanSkuCapacity: 1
    appSvcPlanKind: 'App'
    logAnalyticsWorkspaceName: 'dummyLogAnalytics-${uniqueString(resourceGroup().id)}'
    publicIpAddressName: publicIpAddressName
    publicIpAddressDnsName: 'dummyDns-${uniqueString(resourceGroup().id)}'
    publicIpAddressSku: 'Standard'
    publicIpAddressAllocationType: 'Static'
    publicIpResourceName: 'dummyPip-${uniqueString(resourceGroup().id)}'
    webAppPlanName: 'dummyWebAppPlan-${uniqueString(resourceGroup().id)}'
    webAppPlanSku: 'P2v3'
    sqlAdministratorLogin: sqlAdministratorLogin
    sqlAdministratorLoginPassword: kv.getSecret(sqlAdministratorLoginKeyVaultName)
    sqlServerName: 'dummySqlServer-${uniqueString(resourceGroup().id)}'
    elasticPoolSku: {
      name: 'StandardPool'
      tier: 'Standard'
      capacity: 200
    }
    sqlDatabases: [
      {
        name: 'DUMMY_DB1'
        sku: {
          name: 'ElasticPool'
          tier: 'Standard'
          capacity: 0
        }
        collation: 'Latin1_General_CI_AS'
      }
      {
        name: 'DUMMY_DB2'
        sku: {
          name: 'ElasticPool'
          tier: 'Standard'
          capacity: 0
        }
        collation: 'Latin1_General_CI_AS'
      }
    ]
    sslCertificates: [
      {
        name: pitcherCertName
        properties: {
          keyVaultSecretId: '${vaults_pp_prd_ccert_as_kv_1_uri}/secrets/${pitcherCertKeyVaultSecretName}'
        }
      }
      {
        name: myPitcherCertName
        properties: {
          keyVaultSecretId: '${kvMyPitcherComAu.properties.vaultUri}secrets/${myPitcherCertKeyVaultSecretName}'
        }
      }
    ]
  }
}
