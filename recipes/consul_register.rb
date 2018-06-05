#
# Cookbook:: kafka-pixy
# Recipe:: consul_register
#
# Copyright:: 2018, BaritoLog.
#
#

config = {
  "id": "#{node['hostname']}-kafka-pixy",
  "name": "kafka-pixy",
  "tags": ["app:"],
  "address": node['ipaddress'],
  "port": node[cookbook_name]['grpcPort'],
  "meta": {
    "kafka_topic": node[cookbook_name]['kafka_topic']
  }
}

consul_register_service "kafka-pixy" do
  config config
  config_dir  node[cookbook_name]['consul']['config_dir']
  consul_bin  node[cookbook_name]['consul']['bin']
end
