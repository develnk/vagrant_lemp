#
# Cookbook Name:: phpapp
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
require 'fileutils'

template "90forceyes" do
  path "/etc/apt/apt.conf.d/90forceyes"
  source "90forceyes.erb"
  owner "root"
  group "root"
  mode 0644
end

include_recipe "apt"

apt_repository "php5-5.6" do
  uri "ppa:ondrej/php5-5.6"
  distribution "trusty"
end

include_recipe "nginx"
include_recipe "php"
include_recipe "php::module_mysql"
include_recipe "php::module_curl"
include_recipe "php::module_apc"
include_recipe "php::module_gd"
include_recipe "mysql::client"
include_recipe "mysql::server"
include_recipe "php5-fpm"


template "php.ini" do
  path "#{node['php-fpm']['conf_dir']}/php.ini"
  source "php.ini.erb"
  owner "root"
  group "root"
  mode 0644
  variables(:directives => node['php']['directives'])
  notifies :reload, 'service[php5-fpm]'
end

template 'nginx.conf' do
  path "#{node['nginx']['dir']}/nginx.conf"
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, 'service[nginx]'
end

Dir.mkdir("/var/www") unless File.exists?("/var/www")
FileUtils.chown("vagrant", "vagrant", "/var/www")

# Delete old config files.
Dir.glob("/etc/nginx/sites-enabled/*.conf").each { |file| File.delete(file) }
Dir.glob("/etc/nginx/sites-available/*.conf").each { |file| File.delete(file) }

# nginx.site.conf templates
if node.has_key?("project") && node["project"].has_key?("sites")
  node["project"]["sites"].each do |site|
    site_name = site[0]
    site_port = site[1]

    Dir.mkdir("/var/www/#{site_name}") unless File.exists?("/var/www/#{site_name}")
    FileUtils.chown("vagrant", "vagrant", "/var/www/#{site_name}")

    template "/etc/nginx/sites-available/#{site_name}.conf" do
      source "nginx.site.conf.erb"
      mode "0640"
      owner "root"
      group "root"
      variables(
          :server_name => site_name,
          :server_port => site_port,
          :server_aliases => ["*.#{site_name}"],
          :docroot => "#{node[:doc_root]}/var/www/#{site_name}/project",
          :logdir => "#{node[:nginx][:log_dir]}"
      )
    end

    nginx_site "#{site_name}.conf" do
      :enable
    end
  end
end

php5_fpm_pool "web" do
  pool_user "www-data"
  pool_group "www-data"
  listen_address "127.0.0.1"
  listen_port 9000
  listen_owner "nobody"
  listen_group "nobody"
  listen_mode "0666"
  php_ini_flags ( { "display_errors" => "on", "log_errors" => "on"} )
  php_ini_values ( { "sendmail_path" => "/usr/sbin/sendmail -t -i -f www@develnk.ru", "memory_limit" => "256M"} )
  overwrite true
  action :create
  notifies :restart, "service[#{node["php_fpm"]["package"]}]", :delayed
end
