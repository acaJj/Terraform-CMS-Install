#output "mysql_env" {
#  description = "environment variables for mysql connection"
#  value = docker_container.db.env
#}

output "db_instance_name" {
  description = "db name"
	value = module.mysql_container.db_instance_name
}
