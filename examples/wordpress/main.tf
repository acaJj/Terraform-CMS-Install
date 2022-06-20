terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "docker" {}

module "wp_container" {
  source = "../../modules/wordpress"

  cms_option = true
	docker_instance_name = var.docker_instance_name
	docker_network_name = docker_network.wp_net_example.name
	host_port = var.host_port
	published_port = var.published_port
	db_user = var.db_user
	db_user_pass = var.db_user_pass
	db_name = var.db_name
	db_root_pass = var.db_root_pass
}

resource "docker_network" "wp_net_example" {
  name = var.docker_network_name
}
