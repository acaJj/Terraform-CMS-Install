output "db_instance_name" {
  value = module.mysql_container.db_instance_name
	description = "name of created db instance"
}
