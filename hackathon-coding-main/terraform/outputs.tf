output "aks_cluster_name" {
  description = "AKS cluster name"
  value       = module.aks.cluster_name
}

output "aks_cluster_id" {
  description = "AKS cluster ID"
  value       = module.aks.cluster_id
}

output "acr_login_server" {
  description = "ACR login server"
  value       = module.acr.login_server
}

output "acr_name" {
  description = "ACR name"
  value       = module.acr.acr_name
}

output "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID"
  value       = module.monitoring.log_analytics_workspace_id
}

output "application_insights_instrumentation_key" {
  description = "Application Insights instrumentation key"
  value       = module.monitoring.app_insights_instrumentation_key
  sensitive   = true
}

output "application_gateway_public_ip" {
  description = "Application Gateway public IP address"
  value       = module.application_gateway.public_ip_address
}

output "aks_vnet_id" {
  description = "AKS VNET ID"
  value       = module.aks_networking.vnet_id
}

output "appgw_vnet_id" {
  description = "Application Gateway VNET ID"
  value       = module.appgw_networking.vnet_id
}

output "kube_config" {
  description = "AKS kube config"
  value       = module.aks.kube_config_raw
  sensitive   = true
}
