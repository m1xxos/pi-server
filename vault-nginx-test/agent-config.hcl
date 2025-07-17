
auto_auth {

  method {
    type = "token_file"

    config {
      token_file_path = "/Users/m1xxos/.vault-token"
    }
  }
}

template_config {
  static_secret_render_interval = "5m"
  exit_on_retry_failure         = true
  max_connections_per_host      = 10
}

vault {
  address = "https://vault.local.m1xxos.tech"
}

env_template "CONTACTS_ADMIN_EMAIL" {
  contents             = "{{ with secret \"secret/data/nginx/contacts\" }}{{ .Data.data.admin_email }}{{ end }}"
  error_on_missing_key = true
}
env_template "CONTACTS_SUPPORT_PHONE" {
  contents             = "{{ with secret \"secret/data/nginx/contacts\" }}{{ .Data.data.support_phone }}{{ end }}"
  error_on_missing_key = true
}
env_template "DB_PG_PASS" {
  contents             = "{{ with secret \"secret/data/nginx/db\" }}{{ .Data.data.PG_PASS }}{{ end }}"
  error_on_missing_key = true
}
env_template "SITE_COPYRIGHT_YEAR" {
  contents             = "{{ with secret \"secret/data/nginx/site\" }}{{ .Data.data.copyright_year }}{{ end }}"
  error_on_missing_key = true
}
env_template "SITE_HEADER" {
  contents             = "{{ with secret \"secret/data/nginx/site\" }}{{ .Data.data.header }}{{ end }}"
  error_on_missing_key = true
}
env_template "SITE_SERVER_INFO" {
  contents             = "{{ with secret \"secret/data/nginx/site\" }}{{ .Data.data.server_info }}{{ end }}"
  error_on_missing_key = true
}
env_template "SITE_TITLE" {
  contents             = "{{ with secret \"secret/data/nginx/site\" }}{{ .Data.data.title }}{{ end }}"
  error_on_missing_key = true
}
env_template "SSL_CERT_PATH" {
  contents             = "{{ with secret \"secret/data/nginx/ssl\" }}{{ .Data.data.cert_path }}{{ end }}"
  error_on_missing_key = true
}
env_template "SSL_KEY_PATH" {
  contents             = "{{ with secret \"secret/data/nginx/ssl\" }}{{ .Data.data.key_path }}{{ end }}"
  error_on_missing_key = true
}

exec {
  command                   = ["docker", "compose", "up", "-d"]
  restart_on_secret_changes = "always"
  restart_stop_signal       = "SIGTERM"
}
