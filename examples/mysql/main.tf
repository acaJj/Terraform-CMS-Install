terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "docker" {}

module "mysql_container" {
  source = "../../modules/mysql"


  docker_network_name = docker_network.example_network.name 
	docker_volume_name = docker_volume.example_volume.name
  db_user = var.db_user
	db_user_pass = var.db_user_pass
	db_name = var.db_name
	db_root_pass = var.db_root_pass
}

resource "docker_network" "example_network" {
  name = "sql-example-network"
}

resource "docker_volume" "example_volume" {
  name = "sql-example-volume"
}
