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

resource "docker_container" "lara" {
  count = var.cms_option ? 0 : 1
	image = "laratest"
	name = "lara_container"
	networks_advanced {
    name = docker_network.wp_net.name
	}
	command = [
    "php", "artisan", "serve", "--host=0.0.0.0", "--port=80",
	]

  env = [
    "APP_URL=http://lara.test",
		"DB_HOST=${module.mysql_container.db_instance_name}:3306",
		"DB_USERNAME=${var.db_user}",
		"DB_PASSWORD=${var.db_user_pass}",
		"DB_DATABASE=${var.db_name}",
		"DB_PORT=3306",
		"DB_CONNECTION=mysql",
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

#resource "docker_image" "laravel" {
#  name = data.docker_registry_image.laravel.name
#	pull_triggers = [data.docker_registry_image.laravel.sha256_digest]
#}

#data "docker_registry_image" "mysql" {
	#name = "mysql:latest"
	#}

#data "docker_registry_image" "laravel" {
#	name = "lorisleiva/laravel-docker:latest"
#}
