#cms-integration/modules/mysql

dependency "wordpress" {
  config_path = "../wordpress"
}

inputs = {
  docker_network_name = dependency.wordpress.outputs.docker_network_name
  docker_volume_name = dependency.wordpress.outputs.docker_volume_name
  db_user = dependency.wordpress.inputs.db_user
  db_user_pass = dependency.wordpress.inputs.db_user_pass
  db_name = dependency.wordpress.inputs.db_name
  db_root_pass = dependency.wordpress.inputs.db_root_pass
}
