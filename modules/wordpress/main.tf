terraform {
  required_version = ">= 0.12, < 0.13"
}

module "mysql_container" {
  source = "../mysql"

	docker_network_name = docker_network.wp_net.name
	docker_volume_name = docker_volume.db_data.name

	db_user = var.db_user
	db_user_pass = var.db_user_pass
	db_name = var.db_name
	db_root_pass = var.db_root_pass
}

resource "docker_container" "wp" {
	count = var.cms_option ? 1 : 0

	image = docker_image.wordpress.name
  name = "wp_container"
	restart = "always"
	networks_advanced {
		name = docker_network.wp_net.name
	}

  env =[
		"WORDPRESS_DB_HOST=${module.mysql_container.db_instance_name}:3306",
		"WORDPRESS_DB_USER=${var.db_user}",
	  "WORDPRESS_DB_PASSWORD=${var.db_user_pass}",
		"WORDPRESS_DB_NAME=${var.db_name}"
	]

	ports {
    internal = var.published_port
	  external = var.db_port
	}
}

resource "docker_container" "lara" {
  count = var.cms_option ? 0 : 1

  image = docker_image.laravel.name
	name = "lara_container"
  restart = "always"

  networks_advanced {
    name = docker_network.wp_net.name
	}
  
  env = [
		"DB_HOST=${module.mysql_container.db_instance_name}:3306",
		"DB_USERNAME=${var.db_user}",
		"DB_PASSWORD=${var.db_user_pass}",
		"DB_DATABASE=${var.db_name}"
	]

  ports {
    internal = var.published_port
		external = var.host_port
	}
}

resource "docker_volume" "db_data" {}

resource "docker_network" "wp_net" {
  name = "wordpress-net"
}

resource "docker_image" "wordpress" {
	name = data.docker_registry_image.wordpress.name
	pull_triggers = [data.docker_registry_image.wordpress.sha256_digest]
}

resource "docker_image" "laravel" {
  name = data.docker_registry_image.laravel.name
	pull_triggers = [data.docker_registry_image.laravel.sha256_digest]
}

resource "docker_image" "composer" {
  name = data.docker_registry_image.composer.name
	pull_triggers = [data.docker_registry_image.composer.sha256_digest]
}

#data "docker_registry_image" "mysql" {
	#name = "mysql:latest"
	#}

data "docker_registry_image" "wordpress" {
  name = "wordpress:latest"
}

data "docker_registry_image" "laravel" {
	name = "lorisleiva/laravel-docker:latest"
}

data "docker_registry_image" "composer" {
  name = "composer:latest"
}
