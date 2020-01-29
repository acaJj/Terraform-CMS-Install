variable "cms_option" {
  description = "true = wordpress, false = laravel"
	type = bool
}

variable "published_port" {
  description = "container port published to host"
	type = number
	default = 80
}

variable "cms_port"{
	description = "host port that container port maps to"
	type = number
  default = 8000
}

variable "cms_user"{
  description = "username to login"
	type = string
	default = "user1"
}

variable "cms_user_pass" {
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
