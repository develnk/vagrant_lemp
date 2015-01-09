#
# Cookbook Name:: phpcpd
# Recipe:: composer
#
# Copyright 2013-2014, Escape Studios
#

include_recipe "composer"

phpcpd_dir = "#{Chef::Config['file_cache_path']}/phpcpd"

directory "#{phpcpd_dir}" do
    owner "root"
    group "root"
    mode "0755"
    action :create
end

#figure out what version to install
if node['phpcpd']['version'] != "latest"
    version = node['phpcpd']['version']
else
    version = "*.*.*"
end

#composer.json
template "#{phpcpd_dir}/composer.json" do
    source "composer.json.erb"
    owner "root"
    group "root"
    mode 0600
    variables(
        :version => version,
        :bindir => node['phpcpd']['prefix']
    )
end

#composer update
execute "phpcpd-composer" do
    user "root"
    cwd phpcpd_dir
    command "composer update"
    action :run
end