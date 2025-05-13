
param location string = resourceGroup().location
param storageAccountName string = 'sa-fcnapps-tst'

param tags object = {
  BuiltBy:'daniel.mitchell@pitcher.com.au'
  Version:'0.1'
  Description:'Azure Web Stack Test'
  Environment: 'Test'
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  tags:tags
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

// Blob Services for Storage Account
resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2019-06-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

#disable-next-line outputs-should-not-contain-secrets
output accountKey string = storageAccount.listKeys().keys[0].value
output accountName string = storageAccount.name
