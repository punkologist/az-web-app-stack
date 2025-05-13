/*
Builds a Public IP Address using Bicep/ARM
Reference: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/publicipaddresses?tabs=bicep
*/

@description('Resource location - from Resource Group')
param location string = resourceGroup().location

@description('Tags - with defaults')
param tags object = {
  BuiltBy:'daniel.mitchell@company.com.au'
  Version:'0.1'
  Description:'Azure Web Stack Test'
  Environment: 'Test'
}


@description('Public IP Address Resource Name')
param publicIpResourceName string
@description('Public IP Sku')
@allowed([
  'Basic'
  'Standard'
])
param publicIpAddressSku string


@description('Public IP Allocation Method')
@allowed([
  'Dynamic'
  'Static'
])
param publicIpAddressAllocationType string


@description('Fully qualified domain name associated with the public IP address.')
param domainNameLabel string

//Public IP Resource
resource publicIpAddress 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: publicIpResourceName
  location: location
  tags:tags
  sku: {
    name: publicIpAddressSku
  }
  properties: {
    publicIPAllocationMethod: publicIpAddressAllocationType
    dnsSettings: {
      domainNameLabel: toLower(domainNameLabel)
    }
  }
}

//outputs

// FQDN of PIP
output pip_fqdn string = publicIpAddress.properties.dnsSettings.fqdn

//ID
output pip_id string = publicIpAddress.id
