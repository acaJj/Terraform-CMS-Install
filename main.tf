terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "docker" {
}

module "cms_docker" {
  source = "./modules/docker"
  
	cms_option = var.cms_option
	db_user = var.db_user
	db_user_pass = var.db_user_pass
	host_port = var.host_port
	published_port = var.published_port
  db_name = var.db_name
	db_root_pass = var.db_root_pass
}
