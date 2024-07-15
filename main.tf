resource "cloudflare_pages_project" "blog" {
  account_id = var.cloudflare_account_id
  name = "blog"
  production_branch = "main"
  
  source {
    type = "github"
    config {
        owner = "masinc"
        repo_name  = "blog"
        production_branch = "main"
        pr_comments_enabled           = true
        deployments_enabled           = true
        production_deployment_enabled = true
        preview_branch_includes       = ["dev"]
        preview_branch_excludes       = ["main"]
    }
  }

  build_config {
    build_command = "hugo --gc --minify"
    destination_dir = "public"
  }
}

resource "cloudflare_pages_domain" "blog" {
    project_name = cloudflare_pages_project.blog.name
    account_id = var.cloudflare_account_id
    domain = "blog.masinc.dev"
}


data "cloudflare_zone" "masinc_dev" {
  name = "masinc.dev"
}

resource "cloudflare_record" "masinc_dev_local" {
    zone_id = data.cloudflare_zone.masinc_dev.id
    name = "local.masinc.dev"
    type = "A"
    value = "127.0.0.1"
}

resource "cloudflare_record" "masinc_dev_blog" {
    zone_id = data.cloudflare_zone.masinc_dev.id
    name = "blog.masinc.dev"
    type = "CNAME"
    value = cloudflare_pages_project.blog.subdomain
}
