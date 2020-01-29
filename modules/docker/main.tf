terraform {
  required_version = ">= 0.12, < 0.13"
}

resource "docker_container" "db" {
	image = docker_image.mysql.name
	name = "db"

	restart = "always"
	 networks_advanced {
		name = docker_network.wp_net.name
	}

  env = [
    "MYSQL_ROOT_PASSWORD=${var.db_root_pass}",
		"MYSQL_USER=${var.cms_user}",
		"MYSQL_PASSWORD=${var.cms_user_pass}",
		"MYSQL_DATABASE=${var.db_name}"
	]

	#mounts  {
	#  type = "volume"
	#	target = "/var/lib/mysql"
	#	source = docker_volume.db_data.name
	#}

	volumes {
    volume_name = docker_volume.db_data.name
	  container_path = "/var/lib/mysql"
	}
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
		"WORDPRESS_DB_HOST=${docker_container.db.name}:3306",
		"WORDPRESS_DB_USER=${var.cms_user}",
	  "WORDPRESS_DB_PASSWORD=${var.cms_user_pass}",
		"WORDPRESS_DB_NAME=${var.db_name}"
	]

	ports {
    internal = var.published_port
	  external = var.cms_port
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

  ports {
    internal = var.published_port
		external = var.cms_port
	}
}

resource "docker_volume" "db_data" {}

resource "docker_network" "wp_net" {
  name = "wordpress-net"
}

resource "docker_image" "mysql" {
	name = "mysql:5.7"
}

resource "docker_image" "wordpress" {
	name = data.docker_registry_image.wordpress.name
	pull_triggers = [data.docker_registry_image.wordpress.sha256_digest]
}

resource "docker_image" "laravel" {
  name = data.docker_registry_image.laravel.name
	pull_triggers = [data.docker_registry_image.laravel.sha256_digest]
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
