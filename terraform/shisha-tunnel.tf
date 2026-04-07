resource "random_bytes" "shisha_tunnel_secret" {
  length = 32
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "shisha" {
  account_id    = local.cloudflare_account_id
  name          = "shisha-new"
  config_src    = "cloudflare"
  tunnel_secret = random_bytes.shisha_tunnel_secret.base64
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "shisha" {
  account_id = local.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.shisha.id

  config = {
    ingress = [
      {
        hostname = "photos.m1xxos.online"
        service  = "https://192.168.1.128"
        origin_request = {
          origin_server_name = "photos.m1xxos.online"
        }
      },
      {
        hostname = "cloud.m1xxos.online"
        service  = "https://192.168.1.128"
        origin_request = {
          origin_server_name = "cloud.m1xxos.online"
        }
      },
      {
        hostname = "finn.m1xxos.online"
        service  = "https://192.168.1.128"
        origin_request = {
          origin_server_name = "finn.m1xxos.online"
        }
      },
      {
        hostname = "music.m1xxos.online"
        service  = "https://192.168.1.128"
        origin_request = {
          origin_server_name = "music.m1xxos.online"
        }
      },
      {
        hostname = "lms.m1xxos.online"
        service  = "https://192.168.1.128"
        origin_request = {
          origin_server_name = "lms.m1xxos.online"
        }
      },
      {
        hostname = "lms-api.m1xxos.online"
        service  = "https://192.168.1.128"
        origin_request = {
          origin_server_name = "lms-api.m1xxos.online"
        }
      },
      {
        service = "http_status:404"
      }
    ]
  }
}

resource "cloudflare_dns_record" "photos" {
  zone_id = local.cloudflare_zone_id
  name    = "photos"
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.shisha.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "cloud" {
  zone_id = local.cloudflare_zone_id
  name    = "cloud"
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.shisha.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "finn" {
  zone_id = local.cloudflare_zone_id
  name    = "finn"
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.shisha.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "music" {
  zone_id = local.cloudflare_zone_id
  name    = "music"
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.shisha.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "lms" {
  zone_id = local.cloudflare_zone_id
  name    = "lms"
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.shisha.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "lms_api" {
  zone_id = local.cloudflare_zone_id
  name    = "lms-api"
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.shisha.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}
