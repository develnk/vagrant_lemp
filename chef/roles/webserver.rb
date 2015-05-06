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
    "recipe[drush::git]"
)

default_attributes(
    "redis" => {
        "source" => {
            "version" => "2.6.7",
            "timeout" => "0",
        }
    },

    "drush" => {
        "version" => "master"
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

    # If you want to make the server available externally uncomment lines and change domain settings.
    "postfix" => {
        #"mail_type" => "master",
        "main" => {
            #"inet-interfaces" => "all",
            "myhostname" => "localhost",
            "mydomain" => "localdomain",
            "mydestination" => "localhost.localdomain",
        },
    },

    "dovecot" => {
        "conf" => {
            "mail_location" => "mbox:~/mail:INBOX=/var/mail/%u",
            "mail_access_groups" => "mail",
        },
        "protocols" => {
            "imap" => {},
            "pop3" => {},
        },
        "auth" => {
            "system" => {
                "passdb" => {
                    "driver" => "pam",
                }
            }
        }
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
