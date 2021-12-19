# resource group variables
variable "azure_rg_name" {
    type = string
}

variable "azure_rg_location" {
    type = string
}


# app service plan variables
variable "azure_asp_name" {
    type = string
}

variable "azure_asp_sku_tier" {
    type = string
}

variable "azure_asp_sku_size" {
    type = string
}


# app service variables
variable "azure_app_name" {
    type = string
}

variable "site_config_dotnet_ver" {
    type = string
}

variable "site_config_scm_type" {
    type = string
}

variable "app_settings_value" {
    type = string
}

variable "app_conn_string_name" {
    type = string
}

variable "app_conn_string_type" {
    type = string
}

variable "app_conn_string_value" {
    type = string
}

