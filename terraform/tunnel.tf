resource "random_bytes" "omnivore_tunnel_secret" {
  length = 32
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "omnivore" {
  account_id    = local.cloudflare_account_id
  name          = "omnivore-new"
  config_src    = "cloudflare"
  tunnel_secret = random_bytes.omnivore_tunnel_secret.base64
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "omnivore" {
  account_id = local.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.omnivore.id

  config = {
    ingress = [
      {
        hostname = "omnivore.m1xxos.online"
        service  = "https://192.168.1.77"
        origin_request = {
          origin_server_name = "omnivore.m1xxos.online"
        }
      },
      {
        service = "http_status:404"
      }
    ]
  }
}

resource "cloudflare_dns_record" "omnivore" {
  zone_id = local.cloudflare_zone_id
  name    = "omnivore"
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.omnivore.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}
