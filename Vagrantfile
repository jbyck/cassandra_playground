# -*- mode: ruby -*-
# vi: set ft=ruby :

['berkshelf', 'omnibus'].each { |plugin| Vagrant.require_plugin "vagrant-#{plugin}" }


# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box     = "ubuntu-precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  
  config.vm.hostname = "cassandra-playground-berkshelf"
  
  config.vm.provider :virtualbox
  
  ## Berkshelf Plugin
  config.berkshelf.enabled = true
  ## Chef Omnibus Plugin
  config.omnibus.chef_version = "11.4.0"
  
  config.vm.provision :chef_solo do |chef|
    
    chef.add_recipe 'apt'
    chef.add_recipe 'cassandra'
    
    chef.json = {
      cassandra: {
        version: '2.0.3'
      }
    }
    
  end

end