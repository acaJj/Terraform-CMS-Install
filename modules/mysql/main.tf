terraform {
  required_version = ">= 0.12, < 0.13"
}

resource "docker_container" "db" {
	image = docker_image.mysql.name
	name = "db"

	restart = "always"
	 networks_advanced {
		name = var.docker_network_name
	}

  env = [
    "MYSQL_ROOT_PASSWORD=${var.db_root_pass}",
		"MYSQL_USER=${var.db_user}",
		"MYSQL_PASSWORD=${var.db_user_pass}",
		"MYSQL_DATABASE=${var.db_name}"
	]

	#mounts  {
	#  type = "volume"
	#	target = "/var/lib/mysql"
	#	source = docker_volume.db_data.name
	#}

	volumes {
    volume_name = var.docker_volume_name
	  container_path = "/var/lib/mysql"
	}

	ports {
    internal = 3306
		external = 3306
	}
}

resource "docker_image" "mysql" {
	name = "mysql:5.7"
}
