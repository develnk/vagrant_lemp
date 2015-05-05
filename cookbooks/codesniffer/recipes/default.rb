#
# Cookbook Name:: codesniffer
#
# Recipe:: default
#

include_recipe "php"

execute "pear install PHP_CodeSniffer-1.5.1" do
  not_if "phpcs --version | grep '^PHP_CodeSniffer'"
end
