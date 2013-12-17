# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
VAGRANTFILE_PLUGINS_REQ = ['berkshelf', 'omnibus']

VAGRANTFILE_PLUGINS_REQ.each { |plugin| Vagrant.require_plugin "vagrant-#{plugin}" }

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box     = "ubuntu-precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  
  config.vm.hostname = "cassandra-playground"
  
  config.vm.network :forwarded_port, host: 9160, guest: 9160
  
  config.vm.provider :virtualbox do |v|
   v.customize ["modifyvm", :id, "--memory", 2048]
  end
  
  ## Berkshelf Plugin
  config.berkshelf.enabled = true
  ## Chef Omnibus Plugin
  config.omnibus.chef_version = "11.4.0"
  
  config.vm.provision :chef_solo do |chef|
    
    chef.add_recipe 'apt'
    chef.add_recipe 'vim'
    chef.add_recipe 'identify::system_install'
    chef.add_recipe 'cassandra::datastax'
    
    chef.json = {
      identify: {
        color: 'white',
        use_node_name: true
      },
      cassandra: {
        package_name: 'dsc20',
        jvm: {
          xmx: 512
        },
        listen_address: '',
        seeds: [],
        rpc_address: '0.0.0.0',
        vnodes: 256,
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
