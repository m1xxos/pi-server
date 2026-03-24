data "infisical_secrets" "main" {
  env_slug     = "prod"
  folder_path  = "/"
  workspace_id = var.infisical_workspace_id
}

locals {
  infisical_env_slug     = "prod"
  infisical_folder_path  = "/"
  infisical_workspace_id = var.infisical_workspace_id
  cloudflare_zone_id     = data.infisical_secrets.main.secrets["cloudflare_zone_id"].value
  cloudflare_account_id  = data.infisical_secrets.main.secrets["cloudflare_account_id"].value
}