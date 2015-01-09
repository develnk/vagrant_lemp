name "webserver"
description "Web server developer configuration"

run_list(
    "recipe[apparmor]",
    "recipe[htop]",
    "recipe[nginx]",
    "recipe[php5-fpm::install]",
    "recipe[mysql]",
)

default_attributes(
    "redis" => {
        "source" => {
            "version" => "2.6.7",
            "timeout" => "0",
        }
    },

    "phpapp" => {
        "upload_max_filesize" => "16M",
        "php" => {
            "post_max_size" => "16M",
            "memory_limit" => "256M",
            "max_execution_time" => "30",
            "display_errors" => "On",
            "html_errors" => "Off",
            "display_startup_errors" => "Off",
        },
    },

    "php_fpm" => {
        "run_update" => false
    },

    "mysql" => {
        "server_root_password" => "root",
        "server_debian_password" => "root",
        "server_repl_password" => "root",
        "tunable" => {
            # According to MySQL docs this parameter is most important for InnoDB tables.
            # They suggest to set it to 80% of available to MySQL memory for dedicated servers.
            "innodb_buffer_pool_size" => "512M",
            "table_open_cache" => "512",
            "innodb_additional_mem_pool_size" => "32M",
            "innodb_log_buffer_size" => "16M",
            # InnoDB tables ignore this parameter but according to MySQL docs it still used
            # for temp tables.
            "key_buffer_size" => "32M",
            # Number of open tables for all threads.
            "table_cache" => "512",
            "max_tmp_tables" => "512",
            "thread_cache_size" => "16",
            "join_buffer_size" => "512K",
            "innodb_io_capacity" => "2000",

            # How much of concurrent thread can access InnoDB at the same time.
            # Infinite values for different MySQL versions:
            # 8 for < 5.0.8
            # 20 for 5.0.8 to 5.0.18
            # 0 for 5.0.19 and 5.0.20
            # 8 from 5.0.21
            "innodb_thread_concurrency" => "8",
            "innodb_commit_concurrency" => "8",
            "innodb_read_io_threads" => "8",
            # Flush log to disc is time consuming operation
            # 1 - write and flush to disc at every commit (default)
            # 2 - write at every commit but flush to disc at every second
            # 0 - write and flush every second
            "innodb_flush_log_at_trx_commit" => "0",

            "innodb_open_files" => "4000",
            "net_buffer_length" => "128K",

            "query_cache_limit" => "4M",
            "query_cache_size" => "64M",

            # global memory = key_buffer_size + query_cache_size + innodb_buffer_pool_size + innodb_additional_mem_pool_size + innodb_log_buffer_size
            # per thread memory = read_buffer_size + read_rnd_buffer_size + sort_buffer_size + join_buffer_size + binlog_cache_size + thread_stack + tmp_table_size + net_buffer_length * 2
            # Actually net_buffer_length * 2 should be max_allowed_packet * 2. Also some flags affect these variables. For example if innodb_use_sys_malloc set to ON then
            # innodb_additional_mem_pool_size won't be used.
            # total memory size min = global memory + per thread buffer size
            # total memory size max = global memory + per thread buffer size * max_connections
            "max_connections" => "20",
        }
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

    }
)
