default['phpapp']['hosts'] = ["dev"];
default['phpapp']['upload_max_filesize'] = "16M";
default['phpapp']['php']['post_max_size'] = "16M";
default['phpapp']['php']['memory_limit'] = "256M";
default['phpapp']['php']['max_execution_time'] = "30";
default['phpapp']['php']['display_errors'] = "On";
default['phpapp']['php']['html_errors'] = "Off";
default['phpapp']['php']['display_startup_errors'] = "Off";
default['nginx']['sendfile'] = "off";
default['php-fpm']['conf_dir'] = "/etc/php5/fpm"