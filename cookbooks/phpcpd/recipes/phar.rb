#
# Cookbook Name:: phpcpd
# Recipe:: phar
#
# Copyright 2013-2014, Escape Studios
#

if node['phpcpd']['install_dir'] != ""
    phpcpd_dir = node['phpcpd']['install_dir']
else
    phpcpd_dir = "#{Chef::Config['file_cache_path']}/phpcpd"
end

directory "#{phpcpd_dir}" do
    owner "root"
    group "root"
    mode "0755"
    action :create
end

remote_file "#{phpcpd_dir}/phpcpd.phar" do
    source node['phpcpd']['phar_url']
    mode "0755"
end