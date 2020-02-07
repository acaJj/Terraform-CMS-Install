variable "cms_option" {
  description = "1 = wordpress, 0 = laravel"
	type = bool
}

variable "published_port" {
  description = "container port exposed to host"
	type = number
	default = 80
}

variable "host_port"{
	description = "host port that container port maps to"
	type = number
  default = 8000
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
  description = "mysql db instance name"
	type = string
	default = "db"
}

variable "db_root_pass" {
  description = "password for root access"
	type = string
	default = "db-root-pass"
}
