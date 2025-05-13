param mongoDbAccountName string = 'mongoAccount-tst-${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location
param tags object = {
  BuiltBy:'daniel.mitchell@company.com.au'
  Version:'0.1'
  Description:'Azure Web Stack Test'
  Environment: 'Test'
}
param mongoDatabases array = [
  {
    name: 'BANKINGINTERFACE'
  }
  {
    name: 'NOTF'
  }
]

@allowed([
  'Eventual'
  'ConsistentPrefix'
  'Session'
  'BoundedStaleness'
  'Strong'
])
@description('The default consistency level of the Cosmos DB account.')
param defaultConsistencyLevel string = 'Eventual'

@description('The primary replica region for the Cosmos DB account.')
param primaryRegion string = 'australiaeast'

@description('Specifies the MongoDB server version to use.')
param serverVersion string = '4.2'

param appsVirtualNetworkName string
param appsSubnetNames array = [
  'TstWebSubnet'
  'TstDatabaseSubnet'
  'TstFunctionSubnet'
  'TstAppGatewaySubnet'
]
param appsVirtualNetworkRgName string

resource appSubnets 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' existing =  [for subnetName in appsSubnetNames: {
  name : '${appsVirtualNetworkName}/${subnetName}'
  scope:resourceGroup(appsVirtualNetworkRgName)
}]

var consistencyPolicy = {
  Eventual: {
    defaultConsistencyLevel: 'Eventual'
  }
  ConsistentPrefix: {
    defaultConsistencyLevel: 'ConsistentPrefix'
  }
  Session: {
    defaultConsistencyLevel: 'Session'
  }
  BoundedStaleness: {
    defaultConsistencyLevel: 'BoundedStaleness'
    maxStalenessPrefix: 100
    maxIntervalInSeconds: 5
  }
  Strong: {
    defaultConsistencyLevel: 'Strong'
  }
}

var locations = [
  {
    locationName: primaryRegion
    failoverPriority: 0
    isZoneRedundant: false
  }
]
  // {
  //   locationName: secondaryRegion
  //   failoverPriority: 1
  //   isZoneRedundant: false
  // }


//locatio nset to australia east as south east doesn't have mongo

resource account 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: mongoDbAccountName
  location: location
  kind: 'MongoDB'
  tags:tags
  properties: {
    consistencyPolicy: consistencyPolicy[defaultConsistencyLevel]
    locations: locations
    databaseAccountOfferType: 'Standard'
    isVirtualNetworkFilterEnabled: true
    virtualNetworkRules: [
      {
        id:appSubnets[0].id
        ignoreMissingVNetServiceEndpoint:false
      }
      {
        id:appSubnets[1].id
        ignoreMissingVNetServiceEndpoint:false
      }
      {
        id:appSubnets[2].id
        ignoreMissingVNetServiceEndpoint:false
      }
    ]
    apiProperties: {
      serverVersion: serverVersion
    }
  }
}


// resource databaseAccounts_paasap_webappdbmongoacc_name_resource 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
//   name: mongoDbAccountName
//   location: location
//   tags:tags
//   kind: 'MongoDB'
//   identity: {
//     type: 'None'
//   }
//   properties: {
//     publicNetworkAccess: 'Disabled'
//     enableAutomaticFailover: false
//     enableMultipleWriteLocations: false
//     isVirtualNetworkFilterEnabled: false
//     virtualNetworkRules: []
//     disableKeyBasedMetadataWriteAccess: false
//     enableFreeTier: false
//     enableAnalyticalStorage: false
//     analyticalStorageConfiguration: {
//       schemaType: 'FullFidelity'
//     }
//     databaseAccountOfferType: 'Standard'
//     defaultIdentity: 'FirstPartyIdentity'
//     networkAclBypass: 'None'
//     disableLocalAuth: false
//     consistencyPolicy: {
//       defaultConsistencyLevel: 'Eventual'
//       maxIntervalInSeconds: 5
//       maxStalenessPrefix: 100
//     }
//     apiProperties: {
//       serverVersion: '3.6'
//     }
//     locations: [
//       {
//         locationName: location
//         failoverPriority: 0
//         isZoneRedundant: false
//       }
//     ]
//     cors: []
//     capabilities: [
//       {
//         name: 'EnableMongo'
//       }
//     ]
//     ipRules: []
//     backupPolicy: {
//       type: 'Periodic'
//       periodicModeProperties: {
//         backupIntervalInMinutes: 240
//         backupRetentionIntervalInHours: 8
//         backupStorageRedundancy: 'Geo'
//       }
//     }
//     networkAclBypassResourceIds: []
//   }
// }

resource databases 'Microsoft.DocumentDB/databaseAccounts/mongodbDatabases@2021-04-15'  = [ for i in range(0, length(mongoDatabases)) : {
  parent:account
  name:mongoDatabases[i].name
  properties: {
    resource: {
      id: mongoDatabases[i].name
      
    }
         
  }
}]


output mongoAccountId string = account.id
