# resource group variables
variable "azure_backend_msi" {
    type = string
    default = "8624bf49-5940-421d-941f-7237391c6adf"
}

variable "azure_rg_name" {
    type = string
    default = "devv_weu_rg"
}

variable "azure_rg_location" {
    type = string
    default = "West Europe"
}


# app service plan variables
variable "azure_asp_name" {
    type = string
    default = "terrates-asp"
}

variable "azure_asp_sku_tier" {
    type = string
    default = "Standard"
}

variable "azure_asp_sku_size" {
    type = string
    default = "S1"
}


# app service variables
variable "azure_app_name" {
    type = string
    default = "terra-dev-app-01"
}




