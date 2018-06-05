property :file, String, name_property: true
property :env_vars, Hash, required: true
property :user, String, required: true
property :group, String, required: true

action :create do
  template new_resource.file do
    source 'env_vars.erb'
    owner new_resource.user
    group new_resource.group
    mode 0600
    variables env_vars: new_resource.env_vars.sort.to_h
  end
end
