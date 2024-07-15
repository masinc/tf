variable "cloudflare_account_id" {
    description = "Cloudflare Account ID"
    sensitive = true
    type = string
    nullable = false    
}

variable "cloudflare_zone_id_masinc_dev" {
    description = "Cloudflare Zone ID for masinc.dev"
    sensitive = true
    type = string
    nullable = false
}
