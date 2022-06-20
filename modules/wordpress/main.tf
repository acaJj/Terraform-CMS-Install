terraform {
  required_version = ">= 0.12, < 0.13"
}

resource "docker_container" "wp" {
	count = var.cms_option ? 1 : 0

	image = docker_image.wordpress.name
  name = "wp_container"
	restart = "always"
	networks_advanced {
		name = var.docker_network_name
	}

  env =[
		"WORDPRESS_DB_HOST=${var.db_instance_name}:3306",
		"WORDPRESS_DB_USER=${var.db_user}",
	  "WORDPRESS_DB_PASSWORD=${var.db_user_pass}",
		"WORDPRESS_DB_NAME=${var.db_name}"
	]

	ports {
    internal = var.published_port
	  external = var.host_port
	}
}

resource "docker_container" "lara" {
  count = var.cms_option ? 0 : 1
  image = "laratest"
  name = "lara_container"
	#networks_advanced {
		#   name = docker_network.wp_net.name
		#}

	# laravel must be served on port 80 to run on localhost
  command = [
    "php", "artisan", "serve", "--host=0.0.0.0", "--port=80",
  ]

  env = [
		#   "APP_URL=http://lara.test",
    "DB_HOST=${var.db_instance_name}:3306",
    "DB_USERNAME=${var.db_user}",
    "DB_PASSWORD=${var.db_user_pass}",
    "DB_DATABASE=${var.db_name}",
		#"DB_PORT=3306",
    "DB_CONNECTION=mysql",
  ]

  ports {
    internal = var.published_port
    external = var.host_port
  }
}


#resource "docker_volume" "db_data" {}

#resource "docker_network" "wp_net" {
# name = "wordpress-net"
#}

resource "docker_image" "wordpress" {
	name = data.docker_registry_image.wordpress.name
	pull_triggers = [data.docker_registry_image.wordpress.sha256_digest]
}

data "docker_registry_image" "wordpress" {
  name = "wordpress:latest"
}

#resource "docker_image" "laravel" {
#  name = data.docker_registry_image.laravel.name
# pull_triggers = [data.docker_registry_image.laravel.sha256_digest]
#}

#data "docker_registry_image" "laravel" {
# name = "lorisleiva/laravel-docker:latest"
#}
