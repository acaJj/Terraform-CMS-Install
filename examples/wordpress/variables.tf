variable "published_port" {
  description = "container port published to host"
	type = number
	default = 80
}

variable "host_port"{
	description = "host port that container port maps to"
	type = number
  default = 8000
}

variable "db_instance_name" {
  description = "name of the db"
  type = string
  default = "db"
}

variable "docker_network_name" {
  description = "network name"
  type = string
  default = "terranet"
}

variable "docker_volume_name" {
  description = "storage volume for data persistence"
  type = string
  default = "terrastore"
}

variable "db_user"{
  description = "username to login"
	type = string
	default = "user1"
}

variable "db_user_pass" {
  description = "user login password"
	type = string
	default = "user-pass"
}

variable "db_name"{
  description = "wordpress mysql db instance name"
	type = string
	default = "db"
}

variable "db_root_pass" {
  description = "password for root access"
	type = string
	default = "db-root-pass"
}
