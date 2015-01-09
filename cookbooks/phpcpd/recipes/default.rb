#
# Cookbook Name:: phpcpd
# Recipe:: default
#
# Copyright 2013-2014, Escape Studios
#

case node['phpcpd']['install_method']
    when "composer"
        include_recipe "phpcpd::composer"
    when "phar"
        include_recipe "phpcpd::phar"
end