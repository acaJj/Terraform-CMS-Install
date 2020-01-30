output "db_instance_name" {
  value = docker_container.db.name
	description = "name of the mysql database instance"
}


