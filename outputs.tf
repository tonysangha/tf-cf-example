output "cloudflare_dns_records_created" {
  value = {
    for k, v in cloudflare_record.dns_record :
    k => v.hostname
  }
}

# Expect status code 200 for success
output "cloudflare_cache_purge" {
  value = "Status code for purge: ${data.http.purge_cache.status_code}, ID for event: ${data.http.purge_cache.response_body}"
}