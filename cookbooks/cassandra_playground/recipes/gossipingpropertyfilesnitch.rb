template File.join(node[:cassandra][:conf_dir], 'cassandra-rackdc.properties') do
  source 'cassandra-rackdc.properties.erb'
  owner node[:cassandra][:user]
  group node[:cassandra][:user]
  mode  0644
  variables :snitch => node[:cassandra][:snitch_conf]
end