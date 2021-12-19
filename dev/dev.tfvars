# resourc group
azure_rg_name           = "dev_weu_rg"
azure_rg_location       = "West Europe"

# app service plan
azure_asp_name          = "terra-asp"
azure_asp_sku_tier      = "Free"
azure_asp_sku_size      = "F1"

# app service
azure_app_name          = "terra-dev-app-01"
site_config_dotnet_ver  = "v4.0"
site_config_scm_type    = "LocalGit"
app_settings_value      = "some-value"

# connection strings
app_conn_string_name    = "Database"
app_conn_string_type    = "SQLServer"
app_conn_string_value   = "Server=some-server.mydomain.com;Integrated Security=SSPI"