require 'serverspec'
require 'net/ssh'

set :backend, :ssh

options = Net::SSH::Config.for(host)

options[:host_name] = ENV['KITCHEN_HOSTNAME']
options[:port]      = ENV['KITCHEN_PORT']
options[:user]      = ENV['KITCHEN_USERNAME']
options[:keys]      = ENV['KITCHEN_SSH_KEY']

set :host,        options[:host_name]
set :ssh_options, options

# Disable sudo
# set :disable_sudo, true


# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'
