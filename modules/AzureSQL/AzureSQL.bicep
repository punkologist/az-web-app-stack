/*
Builds an Azure SQL logical server using Bicep/ARM
Reference: https://docs.microsoft.com/en-us/azure/templates/microsoft.sql/2021-02-01-preview/servers?tabs=bicep
*/

@description('Resource location - from Resource Group')
param location string = resourceGroup().location

@description('Tags - with defaults')
param tags object

@description('Azure SQL logical server Resource Name')
param sqlServerName string
@description('Azure SQL server login')
param sqlAdministratorLogin string

@description('Azure SQL server password')
@secure()
param sqlAdministratorLoginPassword string

@description('Minimal TLS version')
@allowed([
  '1.2'
])
param minimalTlsVersion string = '1.2'

param sqlDatabases array

param elasticPoolSku object = {
  name:'StandardPool'
  tier:'Standard'
  capacity:100
}

//Azure SQL Server
resource sqlServer 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: sqlServerName
  location: location
  tags:tags
  properties: {
    administratorLogin: sqlAdministratorLogin
    administratorLoginPassword: sqlAdministratorLoginPassword
    version: '12.0'
    minimalTlsVersion:minimalTlsVersion
    // administrators:{
    //   administratorType:'ActiveDirectory'
    //   principalType:'User'
    //   login:'daniel.mitchell@company.com.au'
    //   sid:objectId

    // }
  }
}

resource sqlElasticPool 'Microsoft.Sql/servers/elasticPools@2023-05-01-preview' ={
  parent: sqlServer
  name: '${sqlServerName}-ep'
  location: location
  tags:tags
  sku:elasticPoolSku
}

resource sqlServerDatabases 'Microsoft.Sql/servers/databases@2021-11-01' = [ for i in range(0, length(sqlDatabases)) : {
  parent: sqlServer
  name:  sqlDatabases[i].name
  tags:tags
  location: location
  sku:sqlDatabases[i].sku
  properties: {
    collation:sqlDatabases[i].collation
    elasticPoolId:sqlElasticPool.id
  }
}]

//outputs

// FQDN of Azure SQL
output sql_fqdn string = sqlServer.properties.fullyQualifiedDomainName

//ID
output sql_id string = sqlServer.id
