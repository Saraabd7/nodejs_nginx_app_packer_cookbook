#
# Cookbook:: nodejs_nginx
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.
# package 'nginx' do #unistall
#   action [:install]
apt_update 'update_sources' do
  action :update
end
include_recipe 'nodejs'
package 'nginx'
# package 'npm'
# include_recipe'nodejs'
npm_package 'pm2'
npm_package 'react'

service 'nginx' do
 action [:enable, :start]
end
# creating template in machine
template "/etc/nginx/sites-available/proxy.conf" do
  source'proxy.conf.erb'
  notifies :restart, 'service[nginx]'
end
# Making symbolic link to above template
 link '/etc/nginx/sites-enabled/proxy.conf' do
   to '/etc/nginx/sites-available/proxy.conf'
   notifies :restart, 'service[nginx]'
 end

 link '/etc/nginx/sites-enabled/default' do
   action :delete
   notifies :restart, 'service[nginx]'
 end
