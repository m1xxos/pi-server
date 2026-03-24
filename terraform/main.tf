terraform {
  required_providers {
    infisical = {
      source  = "Infisical/infisical"
      version = "0.16.4"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
  backend "s3" {
    endpoint                    = "https://storage.yandexcloud.net"
    region                      = "ru-central1"
    bucket                      = var.bucket
    key                         = "pi-tf.tfstate"
    access_key                  = var.access_key
    secret_key                  = var.secret_key
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "infisical" {
  host = "https://infisical.home.m1xxos.tech"
  auth = {
    universal = {
      client_id     = var.infisical_id
      client_secret = var.infisical_secret
    }
  }
}

ephemeral "infisical_secret" "cloudflare_api_token" {
  name         = "cloudflare_api_token"
  env_slug     = local.infisical_env_slug
  folder_path  = local.infisical_folder_path
  workspace_id = local.infisical_workspace_id
}

provider cloudflare {
    api_token = ephemeral.infisical_secret.cloudflare_api_token.value
}