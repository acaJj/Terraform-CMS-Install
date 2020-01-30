variable docker_network_name {
  description = "name of the docker network this db instance is connected to"
	type = string
}

variable docker_volume_name {
  description = "name of the docker volume mounted"
	type = string
}

variable "db_user"{
  description = "username to login"
	type = string
}

variable "db_user_pass" {
  description = "user login password"
	type = string
}

variable "db_name"{
  description = "wordpress mysql db instance name"
	type = string
}

variable "db_root_pass" {
  description = "password for root access"
	type = string
}

