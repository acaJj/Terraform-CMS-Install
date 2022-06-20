#output "mysql_env" {
#  description = "environment variables for mysql connection"
#  value = docker_container.db.env
#}

output "db_instance_name" {
	description = "db name"
	value = var.db_instance_name
}

output "db_network_name" {
  description = "network"
  value = var.docker_network_name
}

output "db_volume_name" {
  description = "storage volume"
	value = var.docker_volume_name
}
