# # encoding: utf-8

# Inspec test for recipe kafka-pixy-cookbook::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  describe group('kafka-pixy') do
    it { should exist }
  end

  describe user('kafka-pixy')  do
    it { should exist }
  end
end

describe directory('/opt') do
  its('mode') { should cmp '0755' }
end

describe directory('/opt/bin') do
  its('mode') { should cmp '0755' }
end

describe directory('/var/cache/chef') do
  its('mode') { should cmp '0755' }
end

describe file('/opt/bin/kafka-pixy') do
  its('mode') { should cmp '0755' }
end

describe file('/etc/default/kafka-pixy') do
  its('mode') { should cmp '0600' }
end

describe systemd_service('kafka-pixy') do
  it { should be_installed }
  it { should be_enabled }
end

describe directory('/etc/kafka-pixy') do
  its('mode') { should cmp '0755' }
end

describe file('/etc/kafka-pixy/default.yaml') do
  its('mode') { should cmp '0600' }
end