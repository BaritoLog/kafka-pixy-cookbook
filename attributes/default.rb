#
# Cookbook:: kafka-pixy
# Attribute:: default
#
# Copyright:: 2018, BaritoLog.
#
#

cookbook_name = 'kafka-pixy'

# User and group of service process
default[cookbook_name]['user'] = 'kafka-pixy'
default[cookbook_name]['group'] = 'kafka-pixy'

# gRpc address, default: localhost:19091
default[cookbook_name]['grpcHost'] = node['ipaddress']
default[cookbook_name]['grpcPost'] = ''
default[cookbook_name]['grpcAddr'] = "#{default[cookbook_name]['grpcHost']}:#{default[cookbook_name]['grpcPort']}"
# tcp address, default: localhost:19092
default[cookbook_name]['tcpAddr'] = ''

# Kafka cluster options, default: localhost:9092
default[cookbook_name]['kafka_hosts'] = []
default[cookbook_name]['kafka_topic'] = ''
# Zookeeper cluster options, default: localhost:2181
default[cookbook_name]['zookeeper_hosts'] = []
default[cookbook_name]['kafka_version'] = '0.11.0.2'

# config YAML variables
default[cookbook_name]['prefix_config_yaml'] = '/etc/kafka-pixy'
default[cookbook_name]['config_yaml_file'] = "#{node[cookbook_name]['prefix_config_yaml']}/default.yaml"
config_yaml_file = default[cookbook_name]['config_yaml_file']
default[cookbook_name]['config_vars'] = {
    'kafka_hosts': default[cookbook_name]['kafka_hosts'],
    'zookeeper_hosts': default[cookbook_name]['zookeeper_hosts'],
    'kafka_version': default[cookbook_name]['kafka_version'],
    'consumer_subscription_timeout': '15s'
}

# Temp directory
default[cookbook_name]['prefix_temp'] = '/var/cache/chef'
# Installation directory
default[cookbook_name]['prefix_root'] = '/opt'
# Where to link binaries
default[cookbook_name]['prefix_bin'] = '/opt/bin'

# Attributes for registering these services to consul
default[cookbook_name]['consul']['config_dir'] = '/opt/consul/etc'
default[cookbook_name]['consul']['bin'] = '/opt/bin/consul'

default[cookbook_name]['version'] = 'v0.15.0'
binary_version = node[cookbook_name]['version']

# where to get the binary
default[cookbook_name]['service_name'] = 'kafka-pixy'
default[cookbook_name]['binary'] = 'kafka-pixy'
binary = default[cookbook_name]['binary']
zip_dir = "#{binary}-#{binary_version}-linux-x86_64"
default[cookbook_name]['zip_file'] = "#{zip_dir}.zip"
default[cookbook_name]['zip_dir'] = zip_dir
zip_file = node[cookbook_name]['zip_file']
default[cookbook_name]['mirror'] =
  "https://github.com/mailgun/kafka-pixy/releases/download/#{binary_version}/#{zip_file}"

# environment variables
default[cookbook_name]['prefix_env_vars'] = '/etc/default'
default[cookbook_name]['env_vars_file'] = "#{node[cookbook_name]['prefix_env_vars']}/#{node[cookbook_name]['service_name']}"
default[cookbook_name]['env_vars'] = {}

# daemon options, used to create the ExecStart option in service
default[cookbook_name]['cli_opts'] = [
    "-config #{config_yaml_file}",
    "-grpcAddr #{default[cookbook_name]['grpcAddr']}",
    "-tcpAddr #{default[cookbook_name]['tcpAddr']}",
]

# log file location
default[cookbook_name]['prefix_log'] = '/var/log/kafka-pixy'
default[cookbook_name]['log_file_name'] = 'error.log'

# Systemd service unit, include config
default[cookbook_name]['systemd_unit'] = {
  'Unit' => {
    'Description' => 'kafka pixy',
    'After' => 'network.target'
  },
  'Service' => {
    'Type' => 'simple',
    'User' => node[cookbook_name]['user'],
    'Group' => node[cookbook_name]['group'],
    'Restart' => 'on-failure',
    'RestartSec' => 2,
    'StartLimitInterval' => 50,
    'StartLimitBurst' => 10,
    'ExecStart' => 'TO_BE_COMPLETED'
  },
  'Install' => {
    'WantedBy' => 'multi-user.target'
  }
}