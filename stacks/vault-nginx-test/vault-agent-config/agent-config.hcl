pid_file = "/tmp/pidfile"

auto_auth {
  method {
    type = "token_file"

    config = {
      token_file_path = "/etc/vault-agent-config/.vault-token"
    }
  }
}

template {
  source      = "/etc/vault-agent-config/index.html.tpl"
  destination = "/vault-agent-output/index.html"
  perms       = 0644
}

