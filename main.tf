terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "docker" {
}

module "mysql_container" {
  source = "./modules/mysql"

  docker_network_name = docker_network.wp_net.name
  docker_volume_name  = docker_volume.db_data.name

  db_user      = var.db_user
  db_user_pass = var.db_user_pass
  db_name      = var.db_name
  db_root_pass = var.db_root_pass
}

module "cms_docker" {
  source = "./modules/wordpress"

  db_instance_name    = module.mysql_container.db_instance_name
  docker_network_name = docker_network.wp_net.name
  cms_option          = var.cms_option
  db_user             = var.db_user
  db_user_pass        = var.db_user_pass
  host_port           = var.host_port
  published_port      = var.published_port
  db_name             = var.db_name
  db_root_pass        = var.db_root_pass
}

resource "docker_volume" "db_data" {}

resource "docker_network" "wp_net" {
  name = "terranet"
}
