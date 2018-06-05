#
# Cookbook:: kafka-pixy-cookbook
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package "zip"

service_name = node[cookbook_name]['service_name']

kafka_pixy_service_account node[cookbook_name]['user'] do
  group node[cookbook_name]['group']
end

kafka_pixy_binary_install service_name do
  version node[cookbook_name]['version']
  prefix_root node[cookbook_name]['prefix_root']
  prefix_bin node[cookbook_name]['prefix_bin']
  prefix_temp node[cookbook_name]['prefix_temp']
  mirror node[cookbook_name]['mirror']
  user node[cookbook_name]['user']
  group node[cookbook_name]['group']
  binary node[cookbook_name]['binary']
  zip_file node[cookbook_name]['zip_file']
  zip_dir node[cookbook_name]['zip_dir']
end

env_vars_file = node[cookbook_name]['env_vars_file']
kafka_pixy_env_vars_file env_vars_file do
  env_vars node[cookbook_name]['env_vars']
  user node[cookbook_name]['user']
  group node[cookbook_name]['group']
end

config_yaml_file = node[cookbook_name]['config_yaml_file']
kafka_pixy_config_yaml_file config_yaml_file do
  prefix_config_yaml node[cookbook_name]['prefix_config_yaml']
  config_vars node[cookbook_name]['config_vars']
  user node[cookbook_name]['user']
  group node[cookbook_name]['group']
end

bin = "#{node[cookbook_name]['prefix_bin']}/#{service_name}"
kafka_pixy_binary_systemd service_name do
  cli_opts node[cookbook_name]['cli_opts']
  systemd_unit node[cookbook_name]['systemd_unit']
  bin bin
  env_vars_file env_vars_file
  prefix_log node[cookbook_name]['prefix_log']
  log_file_name node[cookbook_name]['log_file_name']
end
