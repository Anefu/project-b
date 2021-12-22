module "infra" {
  source       = "./modules/infra"
  region       = var.region
  cidr_block   = var.cidr_block
  nginx_ami    = var.nginx_ami
  web_ami      = var.web_ami
  db_ami       = var.db_ami
  nginx_min    = var.nginx_min
  nginx_max    = var.nginx_min
  web_min      = var.web_min
  web_max      = var.web_max
  domain_name  = var.domain_name
}