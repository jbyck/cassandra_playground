# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
VAGRANTFILE_PLUGINS_REQ = ['berkshelf', 'omnibus']

CONFIG = {nodes: 3, memory: 1024}

def node_ip_by_index(i)
  "192.168.33.1#{i}"
end

def node_name_by_index(i)
  "cass-#{i}"
end

def node_memory
  CONFIG[:memory]
end

ALL_NODE_IPS = (1..CONFIG[:nodes]).collect { |i| node_ip_by_index(i) }

# Require plugins
VAGRANTFILE_PLUGINS_REQ.each { |plugin| Vagrant.require_plugin "vagrant-#{plugin}" }

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box     = "ubuntu-precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"  
  
  ## Berkshelf Plugin
  config.berkshelf.enabled = true
  ## Chef Omnibus Plugin
  config.omnibus.chef_version = "11.4.0"
    
  (1..CONFIG[:nodes]).each do |i|
    
    node_name = node_name_by_index(i)
    
    config.vm.define node_name.to_sym do |n|
            
      n.vm.network :private_network, ip: node_ip_by_index(i), virtualbox__intnet: 'cassandra_network'
           
      n.vm.hostname = node_name
            
      n.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--memory", node_memory]
      end
      
      n.vm.provision :chef_solo do |chef|
    
        chef.add_recipe 'apt'
        chef.add_recipe 'vim'
        chef.add_recipe 'identify::system_install'
        chef.add_recipe 'cassandra::datastax'
        chef.add_recipe 'cassandra_playground'
    
        seed_index = i == 0 ? 0 : i - 1        
    
        chef.json = {
          identify: {
            color: 'white',
            use_node_name: true
          },
          cassandra: {
            package_name: 'dsc20',
            version: '2.0.3',
            jvm: {
              xmx: 512
            },
            listen_address: node_ip_by_index(i),
            seeds: ALL_NODE_IPS,
            rpc_address: '0.0.0.0',
            vnodes: 256,
            snitch: 'GossipingPropertyFileSnitch',
            snitch_conf: {
              dc: 'dc1',
              rack: 'rac1'
            }
          },
          java: {
            install_flavor: 'oracle',
            jdk_version:    '7',
            oracle: {
              accept_oracle_download_terms: true,
            }
          }
        }
    
      end
      
    end      
    
  end

end
