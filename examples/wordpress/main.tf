terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "docker" {}

module "wp_container" {
  source = "../../modules/wordpress"

  cms_option = true
	host_port = var.host_port
	published_port = var.published_port
	db_user = var.db_user
	db_user_pass = var.db_user_pass
	db_name = var.db_name
	db_root_pass = var.db_root_pass
}
