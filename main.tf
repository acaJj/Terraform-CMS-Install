terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "docker" {
}

module "cms_docker" {
  source = "./modules/docker"
  
	cms_option = var.cms_option
	cms_user = var.cms_user
	cms_user_pass = var.cms_user_pass
	cms_port = var.cms_port
	published_port = var.published_port
  db_name = var.db_name
	db_root_pass = var.db_root_pass
}
