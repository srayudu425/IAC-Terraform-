resource "azurerm_log_analytics_workspace" "this" {
  name                = "${var.project_name}-law-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_sku
  retention_in_days   = var.retention_days
  
  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_application_insights" "this" {
  name                = "${var.project_name}-appinsights-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.this.id
  application_type    = "web"
  
  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
