/*
Builds a App Service Plan using Bicep/ARM
Reference: https://docs.microsoft.com/en-us/azure/templates/microsoft.web/serverfarms?tabs=bicep
*/

@description('Resource location - from Resource Group')
param location string = resourceGroup().location
@description('Tags - with defaults')
param tags object
@description('App Service Plan Name')
param appServicePlanName string = 'app-svc-plan-${uniqueString(resourceGroup().id)}'

@description('App Service Plan SKU')
@allowed([
  'F1'
  'S1'
  'B1'
  'B2'
  'B3'
  'S1'
  'S2'
  'S3'
  'P1v2'
  'P2v2'
  'P1v3'
  'P2v3'
  'P3v3'
])
param skuName string

@description('App Service Capacity')
param skuCapacity int


@description('App Svc Plan  Kind')
@allowed([
  'App'
  'Linux'
  'Elastic'
  'FunctionApp'  
])
param appSvcPlanKind string

//App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: appServicePlanName
  location: location
  tags:tags
  kind:appSvcPlanKind
  sku: {
    name: skuName
    capacity: skuCapacity
  }
}

//outputs

//ID
output app_plan_id string = appServicePlan.id
