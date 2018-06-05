property :name, String, name_property: true
property :version, String, required: true
property :prefix_root, String, required: true
property :prefix_bin, String, required: true
property :prefix_temp, String, required: true
property :mirror, String, required: true
property :user, String, required: true
property :group, String, required: true
property :zip_file, String, required: true
property :zip_dir, String, required: true
property :binary, String, required: true

action :create do
  # Create prefix directories
  [
    new_resource.prefix_root,
    new_resource.prefix_bin,
    new_resource.prefix_temp
  ].uniq.each do |dir_path|
    directory "#{cookbook_name}:#{dir_path}" do
      path dir_path
      mode 0755
      recursive true
      action :create
    end
  end

  # Put it into temporary directory first
  # temp_path = "#{new_resource.prefix_temp}/#{new_resource.name}-#{new_resource.version}"
  temp_path = "#{new_resource.prefix_temp}/#{new_resource.zip_file}"

  remote_file temp_path do
    source new_resource.mirror
    owner new_resource.user
    group new_resource.group
    mode 0755
  end

  # Extract it
  execute "extract_#{temp_path}" do
    command "unzip -o #{temp_path} -d #{new_resource.prefix_temp}"
  end

  # Copy it to the root directory
  actual_path = "#{new_resource.prefix_root}/#{new_resource.name}-#{new_resource.version}"
  remote_file actual_path do
    source "file://#{new_resource.prefix_temp}/#{new_resource.zip_dir}/#{new_resource.binary}"
    owner new_resource.user
    group new_resource.group
    mode 0755
  end

  # Link it to the binary directory
  link "#{new_resource.prefix_bin}/#{new_resource.name}" do
    to actual_path
    owner new_resource.user
    group new_resource.group
    mode 0755
  end
end
