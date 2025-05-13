/*
Builds an Azure virtual network using Bicep/ARM
Reference: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/virtualnetworks?tabs=bicep

Note: Limited to a single VNet[0] reference for now
*/

//Version 2.0 - Dynamic VNet configuration

//get location from resource group
@description('Resource location - from Resource Group')
param location string = resourceGroup().location

@description('Tags - with defaults')
param tags object
param remote_vnet_id string = '/subscriptions/98f2eeac-e510-42a0-85d7-da92db65567c/resourceGroups/InfApRG-Core/providers/Microsoft.Network/virtualNetworks/InfApVN-Core'
param dsnServers array 
@description('VNet Prefix')
param vnet_name string
@description('VNet Address Prefix')
param vnet_address_prefix string
@description('VNet Subnets')
param subnets array
param routeTableName string

resource routeTables 'Microsoft.Network/routeTables@2020-11-01' = {
  name: routeTableName
  location: location
  properties: {
    disableBgpRoutePropagation: true
    routes: [
      // {
      //   name: 'default'
      //   properties: {
      //     addressPrefix: '0.0.0.0/0'
      //     nextHopType: 'Internet'
      //     hasBgpOverride: false
      //   }
      // }
      {
        name: 'rfc1918-10'
        properties: {
          addressPrefix: '10.0.0.0/8'
          nextHopType: 'VnetLocal'
          hasBgpOverride: false
        }
      }
			{
        name: 'rfc1918-192'
        properties: {
          addressPrefix: '192.168.0.0/16'
          nextHopType: 'VnetLocal'
          hasBgpOverride: false
        }
      }
			{
        name: 'rfc1918-172'
        properties: {
          addressPrefix: '172.16.0.0/12'
          nextHopType: 'VnetLocal'
          hasBgpOverride: false
        }
      }
    ]
  }
}

var rt = {
	id:routeTables.id
}

//Virtual Network - Dynamically load VNet config
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' =  {
  name: vnet_name
  location: location
  tags:tags
  properties: {
		dhcpOptions:{
			dnsServers:dsnServers
		}
    addressSpace: {
      addressPrefixes: [
        vnet_address_prefix
      ]
    }
		subnets: [for subnet in subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.addressPrefix
				delegations:subnet.delegations
				routeTable: contains(subnet.name,'app_gateway_sn') ? rt : json('null')
				
				//"serviceEndpoints": [] - Empty

				//not empty
				// 	"serviceEndpoints": [
				// 		{
				// 				"service": "Microsoft.Sql",
				// 				"locations": [
				// 						"australiaeast"
				// 				]
				// 		}
				// ],
				
				//Apply the service endpoint policy dynamically
				serviceEndpoints:((!empty(subnet.serviceEndpoints)) ? json('[{"service":"${subnet.serviceEndpoints}"}]'): subnet.serviceEndpoints)
					
      }
    }]
	
    		
	}
}


// resource VnetPeering1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
//   parent: virtualNetwork
//   name: '${virtualNetwork.name}-InfApVN-Core'
//   properties: {
//     allowVirtualNetworkAccess: true
//     allowForwardedTraffic: true
//     allowGatewayTransit: true
//     useRemoteGateways: true
//     remoteVirtualNetwork: {
//       id: remote_vnet_id
//     }
//   }
// }

//outputs [0] - single instance of Vnet only ref

//TODO: find a better way to do this
//ID
output vnet_id string = virtualNetwork.id

//Subnets ID Array
output vnet_subnet_id array =  virtualNetwork.properties.subnets
output vnet_gatewaySubnet_id string = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetwork.name,'${subnets[2].name}')
output vnet_gatewaySubnet_name string = '${subnets[2].name}'
//VNet Name
output vnet_name string = virtualNetwork.name

output vnet_webSubnet_id string = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetwork.name,'${subnets[3].name}')
output vnet_appSubnet_id string = resourceId('Microsoft.Network/virtualNetworks/subnets',virtualNetwork.name,'${subnets[4].name}')
output vnet_sqlSubnet_id string = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetwork.name,'${subnets[5].name}')

