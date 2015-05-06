name "webserver"
description "Web server developer configuration"

run_list(
    "recipe[apt]",
    "recipe[htop]",
    "recipe[nginx]",
    "recipe[php]",
    "recipe[php5-fpm::install]",
    "recipe[git]",
    "recipe[phpapp]",
    "recipe[composer]",
    "recipe[drush::git]",
    "recipe[phing]"
)

default_attributes(
    "drush" => {
        "version" => "master"
    },

    "phing" => {
        "install_method" => "composer"
    },

    "phpapp" => {
        "upload_max_filesize" => "16M",
        "php" => {
            "post_max_size" => "16M",
            "memory_limit" => "256M",
            "max_execution_time" => "120",
            "display_errors" => "On",
            "html_errors" => "Off",
            "display_startup_errors" => "Off",
        },
    },

    # Uncomment this lines if you want to test sending emails from a local server, prepared from the "postfix" recipe.
    "php" => {
        "directives" => {
            "SMTP" => "localhost.localdomain",
            "sendmail_from" => "vagrant@localhost.localdomain",
        },
        "package_options" => "--force-yes"

    },

    "xdebug" => {
        "web_server" => {
            "service_name" => "nginx"
        },
        "config_file" => "/etc/php5/fpm/conf.d/xdebug.ini",
        "directives" => {
            "remote_autostart" => 1,
            "remote_connect_back" => 1,
            "remote_enable" => 1,
            "remote_log" => '/tmp/remote.log'
        }
    }
)
