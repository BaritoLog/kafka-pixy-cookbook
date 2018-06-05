property :file, String, name_property: true
property :config_vars, Hash, required: true
property :user, String, required: true
property :group, String, required: true
property :prefix_config_yaml, String, required: true

action :create do
  directory "#{cookbook_name}:#{new_resource.prefix_config_yaml}" do
    path new_resource.prefix_config_yaml
    mode 0755
    recursive true
    action :create
  end

  template new_resource.file do
    source 'config_yaml.erb'
    owner new_resource.user
    group new_resource.group
    mode 0600
    variables config_vars: new_resource.config_vars.sort.to_h
  end
end
