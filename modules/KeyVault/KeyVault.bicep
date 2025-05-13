/*
Builds an Azure keyvault network using Bicep/ARM
Reference: https://docs.microsoft.com/en-us/azure/templates/microsoft.keyvault/2019-09-01/vaults?tabs=bicep
NOTE: using build 2019-09-01 as its the built on a stable non-preview API channel
*/

//Vars
param vaultName string = 'kv${uniqueString(resourceGroup().id)}' // must be globally unique
param location string = resourceGroup().location
param enabledForDeployment bool = true
param enabledForTemplateDeployment bool = true
param enabledForDiskEncryption bool = true
param enableRbacAuthorization bool = false
param softDeleteRetentionInDays int = 90

@description('Tags - with defaults')
param tags object = {
    'BuiltBy':'azurebicep'
    'Description':'Azure KeyVault'
}

//SKU
@allowed([
  'premium'
  'standard'
])
param sku string = 'standard'


//Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.keyvault/2021-06-01-preview/vaults?tabs=bicep#accesspolicyentry
//Tenant and objectIds
param tenantId string = subscription().tenantId // Application ID of the client making request on behalf of a principal
param objectId string  // The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault.

//Access Policies
param accessPolicies array = [
  {
    tenantId: tenantId
    objectId: objectId
    permissions: {
      keys: [
        'Get'
        'List'
        'Update'
        'Create'
        'Import'
        'Delete'
        'Recover'
        'Backup'
        'Restore'
      ]
      secrets: [
        'Get'
        'List'
        'Set'
        'Delete'
        'Recover'
        'Backup'
        'Restore'
      ]
      certificates: [
        'Get'
        'List'
        'Update'
        'Create'
        'Import'
        'Delete'
        'Recover'
        'Backup'
        'Restore'
        'ManageContacts'
        'ManageIssuers'
        'GetIssuers'
        'ListIssuers'
        'SetIssuers'
        'DeleteIssuers'
      ]
    }
  }
]

param networkAcls object = {
  ipRules: []
  virtualNetworkRules: []
}

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: vaultName
  location: location
  tags:tags
  properties: {
    tenantId: tenantId
    sku: {
      family: 'A'
      name: sku
    }
    accessPolicies: accessPolicies
    enabledForDeployment: enabledForDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
    enabledForTemplateDeployment: enabledForTemplateDeployment
    softDeleteRetentionInDays: softDeleteRetentionInDays
    enableRbacAuthorization: enableRbacAuthorization
    networkAcls: networkAcls
  }
}

//outputs
output vault_uri string = keyVault.properties.vaultUri
output vault_id string = keyVault.id
