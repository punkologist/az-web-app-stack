/*
Builds an Azure keyvault secret using Bicep/ARM
Reference: https://docs.microsoft.com/en-us/azure/templates/microsoft.keyvault/2019-09-01/vaults/secrets?tabs=bicep
NOTE: using build 2019-09-01 as its the built on a stable non-preview API channel
*/

//Vars
param existingVaultName string 
param secretName string 

@maxLength(15)
@secure()
param secretValue string


@description('Tags - with defaults')
param tags object = {
    'BuiltBy':'azurebicep'
    'Description':'Azure KeyVault Secret'
}

resource KeyVaultSecret 'Microsoft.KeyVault/vaults/secrets@2019-09-01' = {
  name: '${existingVaultName}/${secretName}'
  tags:tags
  properties: {
    value: secretValue
  }
}
