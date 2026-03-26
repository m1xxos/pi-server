locals {
  pi-ip      = "192.168.1.77"
  local_name = "pi.m1xxos.online"
}

resource "cloudflare_dns_record" "pi-main" {
  zone_id = local.cloudflare_zone_id
  name    = local.local_name
  content = local.pi-ip
  type    = "A"
  ttl     = 300
}

resource "cloudflare_dns_record" "pi-extra" {
  zone_id = local.cloudflare_zone_id
  name    = "*.${local.local_name}"
  content = local.local_name
  type    = "CNAME"
  ttl     = 300
}

resource "cloudflare_dns_record" "home" {
  zone_id = local.cloudflare_zone_id
  name    = "home.m1xxos.online"
  content = "192.168.1.128"
  type    = "A"
  ttl     = 300
}

resource "cloudflare_dns_record" "home-extra" {
  zone_id = local.cloudflare_zone_id
  name    = "*.home.m1xxos.online"
  content = cloudflare_dns_record.home.name
  type    = "CNAME"
  ttl     = 300
}
