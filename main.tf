provider "azurerm" {
  features { }
}

# reource group for function App and storage accounts
resource "azurerm_resource_group" "tfresourcegroup" {
  name     = "terraform_rg"
  location = "West Europe"
}

# storage account of function app
resource "azurerm_storage_account" "functionappstorage" {
  name                     = "functionsappreprosa"
  resource_group_name      = azurerm_resource_group.tfresourcegroup.name
  location                 = azurerm_resource_group.tfresourcegroup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# app service plan for function App
resource "azurerm_app_service_plan" "myappserviceplan" {
  name                = "azure-functions-repro-service-plan"
  location            = azurerm_resource_group.tfresourcegroup.location
  resource_group_name = azurerm_resource_group.tfresourcegroup.name

  sku {
    tier = "Premium"
    size = "P1"
  }
}

# function app
resource "azurerm_function_app" "terrafuncrepro" {
  name                       = "repro-azure-functions"
  location                   = azurerm_resource_group.tfresourcegroup.location
  resource_group_name        = azurerm_resource_group.tfresourcegroup.name
  app_service_plan_id        = azurerm_app_service_plan.myappserviceplan.id
  storage_account_name       = azurerm_storage_account.functionappstorage.name
  storage_account_access_key = azurerm_storage_account.functionappstorage.primary_access_key
}

# vnet for resources
resource "azurerm_virtual_network" "tfvnet" {
  name                = "terraformvirtualnetwork"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.tfresourcegroup.location
  resource_group_name = azurerm_resource_group.tfresourcegroup.name
}

# subnet for the virtual network
resource "azurerm_subnet" "tfsubnet" {
  name                 = "terraform_subnetname"
  resource_group_name  = azurerm_resource_group.tfresourcegroup.name
  virtual_network_name = azurerm_virtual_network.tfvnet.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}

# creating the storage account for the Vnet
resource "azurerm_storage_account" "tfchisomstorage" {
  name                = "tfchisomstorage"
  resource_group_name = azurerm_resource_group.tfresourcegroup.name

  location                 = azurerm_resource_group.tfresourcegroup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    ip_rules                   = ["100.0.0.1"]
    virtual_network_subnet_ids = [azurerm_subnet.tfsubnet.id]
  }

  tags = {
    environment = "staging"
  }

  # dependency on function App storage being created for function App to work
  depends_on = [
    azurerm_storage_account.functionappstorage
  ]
}