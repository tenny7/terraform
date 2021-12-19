provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resourcegroup" {
  name     = var.azure_rg_name
  location = var.azure_rg_location
}

resource "azurerm_app_service_plan" "asp" {
  name                = var.azure_asp_name
  location            = var.azure_rg_location
  resource_group_name = var.azure_rg_name

  sku {
    tier = var.azure_asp_sku_tier
    size = var.azure_asp_sku_size
  }

  depends_on = [
    azurerm_resource_group.resourcegroup
  ]
}

resource "azurerm_app_service" "appservice" {
  name                = var.azure_app_name
  location            = var.azure_rg_location
  resource_group_name = var.azure_rg_name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    dotnet_framework_version = var.site_config_dotnet_ver
    scm_type                 = var.site_config_scm_type
  }

  app_settings = {
    "SOME_KEY" = var.app_settings_value
  }

  connection_string {
    name  = var.app_conn_string_name
    type  = var.app_conn_string_type
    value = var.app_conn_string_value
  }

  depends_on = [
    azurerm_app_service_plan.asp
  ]
}