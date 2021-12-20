provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
  }
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

  depends_on = [
    azurerm_app_service_plan.asp
  ]
}