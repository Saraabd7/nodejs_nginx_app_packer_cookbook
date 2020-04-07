#
# Cookbook:: nodejs_nginx
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'nodejs_nginx::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'runs apt-get update' do
      expect(chef_run).to update_apt_update 'update_sources'
    end
# Installing:
  # install nginx
    it 'should install nginx' do
      expect(chef_run).to install_package 'nginx'
    end
  # install nodejs
# get this tob installed from a dependency
    it 'should install nodejs from recipe' do
      expect(chef_run). to include_recipe 'nodejs'
    end
#Services:
# nginx
    it 'should enables nginx' do
        expect(chef_run).to enable_service 'nginx'
    end
    it 'should start nginx' do
        expect(chef_run).to start_service 'nginx'
    end
  # start and enable

# if we create it a new proxy.config file for nginx
    it 'should create a proxy.conf template in/etc/nginx/site-available' do
        expect(chef_run).to create_template "/etc/nginx/sites-available/proxy.conf"
    end

    it 'should create a symlink of proxy.conf from sites-available to sites-enabled' do
      expect(chef_run).to create_link('/etc/nginx/sites-enabled/proxy.conf').with_link_type(:symbolic)
    end
    it 'should delete a symlink from the default config in sites-enabled' do
      expect(chef_run).to delete_link('/etc/nginx/sites-enabled/default')
    end
    it 'should install pm2 via npm' do
      expect(chef_run).to install_nodejs_npm 'pm2'
    end
   it 'should install react via npm' do
       expect(chef_run).to install_nodejs_npm 'react'
     end
 end
end
