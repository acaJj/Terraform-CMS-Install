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
