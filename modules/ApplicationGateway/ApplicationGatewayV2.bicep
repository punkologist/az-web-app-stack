/*
Builds a Application Gateway using Bicep/ARM
Reference: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-02-01/applicationgateways?tabs=bicep
*/

@description('Resource location - from Resource Group')
param location string = resourceGroup().location

@description('Tags - with defaults')
param tags object

@description('Application Gateway Name')
param applicationGatewayName string

@description('App GW SKU Name')
@allowed([
  'Standard_Small'
  'Standard_Medium'
  'Standard_Large'
  'Standard_v2'
  'WAF_v2'
])
param sku_name string 


@description('App GW SKU Tier')
@allowed([
  'Standard_v2'
  'WAF_v2'
])
param sku_tier string


// @description('App GW SKU Capacity - 1-32 for v1, 1-125 for v2')
// param sku_capacity int = 1

@description('HTTP2 is enabled on the application gateway resource.')
param enableHttp2 bool = true

@description('App Gateway - gatewayIPConfigurations')
param gatewayIPConfigurations array 

@description('App Gateway - frontendIPConfigurations')
param frontendIPConfigurations array 


@description('App Gateway - frontendPorts')
param frontendPorts array

@description('App Gateway - backendAddressPools')
param backendAddressPools array
@description('App Gateway - backendHttpSettingsCollection')
param backendHttpSettingsCollection array

@description('App Gateway - httpListeners')
param httpListeners array

@description('App Gateway - requestRoutingRules')
param requestRoutingRules array 

@description('App Gateway - Probes')
param probes array 

@description('Ssl Certificates')
param sslCertificates array

@description('Redirect Configurations')
param redirectConfigurations array

@description('Name for the firewall policy')
param firewallPolicyName string
param userAssignedIdentityId string

resource webappfirewall 'Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies@2022-07-01' = {
  name:firewallPolicyName
  location:location
  properties:{
    policySettings:{
      requestBodyCheck:false
      maxRequestBodySizeInKb:128
      fileUploadLimitInMb:100
      state:'Enabled'
      mode:'Detection'
    }
    managedRules:{
       managedRuleSets:[
        {
          ruleSetType:'OWASP'
          ruleSetVersion: '3.2'
          ruleGroupOverrides: [
            {
              ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
              rules: [
                {
                  ruleId: '920230'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920121'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920160'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920170'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920171'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920180'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920190'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920200'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920201'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920202'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920210'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920220'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920240'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920250'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920260'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920270'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920271'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920272'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920273'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920274'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920280'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920290'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920300'
                  state: 'Disabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920310'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920311'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920320'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920330'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920340'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920341'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920350'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920420'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920430'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920440'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920450'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920460'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920470'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '920480'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'General'
              rules: [
                {
                  ruleId: '200002'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '200003'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '200004'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
              rules: [
                {
                  ruleId: '911100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
              rules: [
                {
                  ruleId: '913100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '913101'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '913102'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '913110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '913120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
              rules: [
                {
                  ruleId: '921110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '921120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '921130'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '921140'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '921150'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '921151'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '921160'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '921170'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '921180'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
              rules: [
                {
                  ruleId: '930100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '930110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '930120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '930130'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
              rules: [
                {
                  ruleId: '931100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '931110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '931120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '931130'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
              rules: [
                {
                  ruleId: '932100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932105'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932106'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932115'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932130'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932140'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932150'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932160'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932170'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932171'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932180'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '932190'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
              rules: [
                {
                  ruleId: '933100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933111'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933130'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933131'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933140'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933150'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933151'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933160'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933161'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933170'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933180'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933190'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933200'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '933210'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
              rules: [
                {
                  ruleId: '941100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941101'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941130'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941140'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941150'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941160'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941170'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941180'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941190'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941200'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941210'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941220'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941230'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941240'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941250'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941260'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941270'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941280'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941290'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941300'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941310'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941320'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941330'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941340'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941350'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '941360'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
              rules: [
                {
                  ruleId: '942100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942130'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942140'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942150'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942160'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942170'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942180'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942190'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942200'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942210'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942220'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942230'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942240'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942250'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942251'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942260'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942270'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942280'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942290'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942300'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942310'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942320'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942330'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942340'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942350'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942360'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942361'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942370'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942380'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942390'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942400'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942410'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942420'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942421'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942430'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942431'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942432'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942440'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942450'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942460'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942470'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942480'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942490'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '942500'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
              rules: [
                {
                  ruleId: '943100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '943110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '943120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
              rules: [
                {
                  ruleId: '944100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '944110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '944120'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '944130'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '944200'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '944210'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '944240'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '944250'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
            {
              ruleGroupName: 'Known-CVEs'
              rules: [
                {
                  ruleId: '800100'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '800110'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '800111'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '800112'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
                {
                  ruleId: '800113'
                  state: 'Enabled'
                  action: 'AnomalyScoring'
                }
              ]
            }
          ]                  
        }
       ]
       exclusions: [
        {
          matchVariable: 'RequestCookieNames'
          selectorMatchOperator: 'StartsWith'
          selector: '.AspNet.Consent'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestCookieNames'
          selectorMatchOperator: 'StartsWith'
          selector: '.AspNetCore.Antiforgery'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestCookieNames'
          selectorMatchOperator: 'StartsWith'
          selector: '.AspNetCore.Identity.Application'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestArgNames'
          selectorMatchOperator: 'StartsWith'
          selector: '_RequestVerificationToken'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestArgNames'
          selectorMatchOperator: 'Equals'
          selector: 'id_token'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestArgNames'
          selectorMatchOperator: 'Equals'
          selector: 'state'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestCookieNames'
          selectorMatchOperator: 'StartsWith'
          selector: '.AspNetCore.Correlation.oidc'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestCookieNames'
          selectorMatchOperator: 'StartsWith'
          selector: '.AspNetCore.Cookies'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestCookieNames'
          selectorMatchOperator: 'StartsWith'
          selector: '.AspNetCore.OpenIdConnect.Nonce.'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestCookieKeys'
          selectorMatchOperator: 'StartsWith'
          selector: '.AspNetCore.OpenIdConnect.Nonce.'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestArgNames'
          selectorMatchOperator: 'Equals'
          selector: 'rm'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestArgNames'
          selectorMatchOperator: 'Equals'
          selector: 'id'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestArgNames'
          selectorMatchOperator: 'Equals'
          selector: 'ru'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestCookieNames'
          selectorMatchOperator: 'StartsWith'
          selector: 'FedAuth2'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestArgNames'
          selectorMatchOperator: 'Equals'
          selector: 'wresult'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestCookieNames'
          selectorMatchOperator: 'StartsWith'
          selector: '.com.auth0.auth.ru'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestCookieNames'
          selectorMatchOperator: 'StartsWith'
          selector: 'com.auth0.auth.ru'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestCookieNames'
          selectorMatchOperator: 'StartsWith'
          selector: 'FedAuth'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestCookieNames'
          selectorMatchOperator: 'StartsWith'
          selector: '.AspNet.Cookies'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
        {
          matchVariable: 'RequestHeaderNames'
          selectorMatchOperator: 'Equals'
          selector: 'user-agent'
          exclusionManagedRuleSets: [
            {
              ruleSetType: 'OWASP'
              ruleSetVersion: '3.2'
              ruleGroups: [
                {
                  ruleGroupName: 'General'
                  rules: [
                    {
                      ruleId: '200002'
                    }
                    {
                      ruleId: '200003'
                    }
                    {
                      ruleId: '200004'
                    }
                  ]
                }
                {
                  ruleGroupName: 'Known-CVEs'
                  rules: [
                    {
                      ruleId: '800100'
                    }
                    {
                      ruleId: '800110'
                    }
                    {
                      ruleId: '800111'
                    }
                    {
                      ruleId: '800112'
                    }
                    {
                      ruleId: '800113'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-911-METHOD-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '911100'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-913-SCANNER-DETECTION'
                  rules: [
                    {
                      ruleId: '913100'
                    }
                    {
                      ruleId: '913101'
                    }
                    {
                      ruleId: '913102'
                    }
                    {
                      ruleId: '913110'
                    }
                    {
                      ruleId: '913120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-920-PROTOCOL-ENFORCEMENT'
                  rules: [
                    {
                      ruleId: '920100'
                    }
                    {
                      ruleId: '920120'
                    }
                    {
                      ruleId: '920121'
                    }
                    {
                      ruleId: '920160'
                    }
                    {
                      ruleId: '920170'
                    }
                    {
                      ruleId: '920171'
                    }
                    {
                      ruleId: '920180'
                    }
                    {
                      ruleId: '920190'
                    }
                    {
                      ruleId: '920200'
                    }
                    {
                      ruleId: '920201'
                    }
                    {
                      ruleId: '920202'
                    }
                    {
                      ruleId: '920210'
                    }
                    {
                      ruleId: '920220'
                    }
                    {
                      ruleId: '920230'
                    }
                    {
                      ruleId: '920240'
                    }
                    {
                      ruleId: '920250'
                    }
                    {
                      ruleId: '920260'
                    }
                    {
                      ruleId: '920270'
                    }
                    {
                      ruleId: '920271'
                    }
                    {
                      ruleId: '920272'
                    }
                    {
                      ruleId: '920273'
                    }
                    {
                      ruleId: '920274'
                    }
                    {
                      ruleId: '920280'
                    }
                    {
                      ruleId: '920290'
                    }
                    {
                      ruleId: '920300'
                    }
                    {
                      ruleId: '920310'
                    }
                    {
                      ruleId: '920311'
                    }
                    {
                      ruleId: '920320'
                    }
                    {
                      ruleId: '920330'
                    }
                    {
                      ruleId: '920340'
                    }
                    {
                      ruleId: '920341'
                    }
                    {
                      ruleId: '920350'
                    }
                    {
                      ruleId: '920420'
                    }
                    {
                      ruleId: '920430'
                    }
                    {
                      ruleId: '920440'
                    }
                    {
                      ruleId: '920450'
                    }
                    {
                      ruleId: '920460'
                    }
                    {
                      ruleId: '920470'
                    }
                    {
                      ruleId: '920480'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-921-PROTOCOL-ATTACK'
                  rules: [
                    {
                      ruleId: '921110'
                    }
                    {
                      ruleId: '921120'
                    }
                    {
                      ruleId: '921130'
                    }
                    {
                      ruleId: '921140'
                    }
                    {
                      ruleId: '921150'
                    }
                    {
                      ruleId: '921151'
                    }
                    {
                      ruleId: '921160'
                    }
                    {
                      ruleId: '921170'
                    }
                    {
                      ruleId: '921180'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-930-APPLICATION-ATTACK-LFI'
                  rules: [
                    {
                      ruleId: '930100'
                    }
                    {
                      ruleId: '930110'
                    }
                    {
                      ruleId: '930120'
                    }
                    {
                      ruleId: '930130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-931-APPLICATION-ATTACK-RFI'
                  rules: [
                    {
                      ruleId: '931100'
                    }
                    {
                      ruleId: '931110'
                    }
                    {
                      ruleId: '931120'
                    }
                    {
                      ruleId: '931130'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-932-APPLICATION-ATTACK-RCE'
                  rules: [
                    {
                      ruleId: '932100'
                    }
                    {
                      ruleId: '932105'
                    }
                    {
                      ruleId: '932106'
                    }
                    {
                      ruleId: '932110'
                    }
                    {
                      ruleId: '932115'
                    }
                    {
                      ruleId: '932120'
                    }
                    {
                      ruleId: '932130'
                    }
                    {
                      ruleId: '932140'
                    }
                    {
                      ruleId: '932150'
                    }
                    {
                      ruleId: '932160'
                    }
                    {
                      ruleId: '932170'
                    }
                    {
                      ruleId: '932171'
                    }
                    {
                      ruleId: '932180'
                    }
                    {
                      ruleId: '932190'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-933-APPLICATION-ATTACK-PHP'
                  rules: [
                    {
                      ruleId: '933100'
                    }
                    {
                      ruleId: '933110'
                    }
                    {
                      ruleId: '933111'
                    }
                    {
                      ruleId: '933120'
                    }
                    {
                      ruleId: '933130'
                    }
                    {
                      ruleId: '933131'
                    }
                    {
                      ruleId: '933140'
                    }
                    {
                      ruleId: '933150'
                    }
                    {
                      ruleId: '933151'
                    }
                    {
                      ruleId: '933160'
                    }
                    {
                      ruleId: '933161'
                    }
                    {
                      ruleId: '933170'
                    }
                    {
                      ruleId: '933180'
                    }
                    {
                      ruleId: '933190'
                    }
                    {
                      ruleId: '933200'
                    }
                    {
                      ruleId: '933210'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-941-APPLICATION-ATTACK-XSS'
                  rules: [
                    {
                      ruleId: '941100'
                    }
                    {
                      ruleId: '941101'
                    }
                    {
                      ruleId: '941110'
                    }
                    {
                      ruleId: '941120'
                    }
                    {
                      ruleId: '941130'
                    }
                    {
                      ruleId: '941140'
                    }
                    {
                      ruleId: '941150'
                    }
                    {
                      ruleId: '941160'
                    }
                    {
                      ruleId: '941170'
                    }
                    {
                      ruleId: '941180'
                    }
                    {
                      ruleId: '941190'
                    }
                    {
                      ruleId: '941200'
                    }
                    {
                      ruleId: '941210'
                    }
                    {
                      ruleId: '941220'
                    }
                    {
                      ruleId: '941230'
                    }
                    {
                      ruleId: '941240'
                    }
                    {
                      ruleId: '941250'
                    }
                    {
                      ruleId: '941260'
                    }
                    {
                      ruleId: '941270'
                    }
                    {
                      ruleId: '941280'
                    }
                    {
                      ruleId: '941290'
                    }
                    {
                      ruleId: '941300'
                    }
                    {
                      ruleId: '941310'
                    }
                    {
                      ruleId: '941320'
                    }
                    {
                      ruleId: '941330'
                    }
                    {
                      ruleId: '941340'
                    }
                    {
                      ruleId: '941350'
                    }
                    {
                      ruleId: '941360'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-942-APPLICATION-ATTACK-SQLI'
                  rules: [
                    {
                      ruleId: '942100'
                    }
                    {
                      ruleId: '942110'
                    }
                    {
                      ruleId: '942120'
                    }
                    {
                      ruleId: '942130'
                    }
                    {
                      ruleId: '942140'
                    }
                    {
                      ruleId: '942150'
                    }
                    {
                      ruleId: '942160'
                    }
                    {
                      ruleId: '942170'
                    }
                    {
                      ruleId: '942180'
                    }
                    {
                      ruleId: '942190'
                    }
                    {
                      ruleId: '942200'
                    }
                    {
                      ruleId: '942210'
                    }
                    {
                      ruleId: '942220'
                    }
                    {
                      ruleId: '942230'
                    }
                    {
                      ruleId: '942240'
                    }
                    {
                      ruleId: '942250'
                    }
                    {
                      ruleId: '942251'
                    }
                    {
                      ruleId: '942260'
                    }
                    {
                      ruleId: '942270'
                    }
                    {
                      ruleId: '942280'
                    }
                    {
                      ruleId: '942290'
                    }
                    {
                      ruleId: '942300'
                    }
                    {
                      ruleId: '942310'
                    }
                    {
                      ruleId: '942320'
                    }
                    {
                      ruleId: '942330'
                    }
                    {
                      ruleId: '942340'
                    }
                    {
                      ruleId: '942350'
                    }
                    {
                      ruleId: '942360'
                    }
                    {
                      ruleId: '942361'
                    }
                    {
                      ruleId: '942370'
                    }
                    {
                      ruleId: '942380'
                    }
                    {
                      ruleId: '942390'
                    }
                    {
                      ruleId: '942400'
                    }
                    {
                      ruleId: '942410'
                    }
                    {
                      ruleId: '942420'
                    }
                    {
                      ruleId: '942421'
                    }
                    {
                      ruleId: '942430'
                    }
                    {
                      ruleId: '942431'
                    }
                    {
                      ruleId: '942432'
                    }
                    {
                      ruleId: '942440'
                    }
                    {
                      ruleId: '942450'
                    }
                    {
                      ruleId: '942460'
                    }
                    {
                      ruleId: '942470'
                    }
                    {
                      ruleId: '942480'
                    }
                    {
                      ruleId: '942490'
                    }
                    {
                      ruleId: '942500'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION'
                  rules: [
                    {
                      ruleId: '943100'
                    }
                    {
                      ruleId: '943110'
                    }
                    {
                      ruleId: '943120'
                    }
                  ]
                }
                {
                  ruleGroupName: 'REQUEST-944-APPLICATION-ATTACK-JAVA'
                  rules: [
                    {
                      ruleId: '944100'
                    }
                    {
                      ruleId: '944110'
                    }
                    {
                      ruleId: '944120'
                    }
                    {
                      ruleId: '944130'
                    }
                    {
                      ruleId: '944200'
                    }
                    {
                      ruleId: '944210'
                    }
                    {
                      ruleId: '944240'
                    }
                    {
                      ruleId: '944250'
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    }
  }
}


//Application Gateway
resource applicationGateway 'Microsoft.Network/applicationGateways@2022-05-01' = {
  name: applicationGatewayName
  location: location
  tags:tags
  identity:{
    type:'UserAssigned'
    userAssignedIdentities:{
       '${userAssignedIdentityId}':{}
  }
  }
  properties: {
    enableHttp2:enableHttp2
    sku: {
      name: sku_name
      tier: sku_tier
    }
    autoscaleConfiguration:{
      minCapacity: 2
      maxCapacity:10
    }
    gatewayIPConfigurations: gatewayIPConfigurations     
    frontendIPConfigurations: frontendIPConfigurations
    frontendPorts: frontendPorts    
    backendAddressPools: backendAddressPools
    backendHttpSettingsCollection: backendHttpSettingsCollection
    httpListeners: httpListeners
    requestRoutingRules: requestRoutingRules
    sslCertificates:sslCertificates
    redirectConfigurations: redirectConfigurations
    forceFirewallPolicyAssociation:true
    webApplicationFirewallConfiguration:{
      enabled:true
      firewallMode:'Prevention'
      ruleSetType:'OWASP'
      ruleSetVersion:'3.2'
    }
    firewallPolicy:{
      id:webappfirewall.id
    }
    probes:probes
       
    // trustedRootCertificates: trustedRootCertificates
  }  
}

//outputs

//ID
output app_gateway_id string = applicationGateway.id
