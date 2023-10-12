# Create Record's in Cloudflare

resource "cloudflare_record" "dns_record" {

  for_each = var.dns_records

  zone_id = var.cloudflare_zone_id
  name    = each.value.name
  value   = each.value.value
  type    = each.value.type
  ttl     = each.value.ttl
}

# Using the HTTP Provider, execute a purge of Cloudflare's cache for a specific zone
# https://developers.cloudflare.com/api/operations/zone-purge?schema_url

data "http" "purge_cache" {
  url    = "https://api.cloudflare.com/client/v4/zones/${var.cloudflare_zone_id}/purge_cache"
  method = "POST"

  request_headers = {
    Accept        = "application/json",
    Authorization = "Bearer ${var.cloudflare_api_token}"
  }

  # Purge everything, options are everything, tags, hosts, prefixes
  request_body = "{\"purge_everything\":true}"
}