snitch = node[:cassandra][:snitch]

include_recipe "cassandra_playground::#{snitch.to_s.downcase}" if snitch and snitch.kind_of?(String)
