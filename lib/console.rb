require 'bundler'
Bundler.require
require 'cql'


client = Cql::Client.connect(hosts: ['192.168.33.11'])
client.use('system')

binding.pry
