source "https://supermarket.chef.io"

metadata

cookbook 'apt'
cookbook 'chef-client', '> 3.0'
cookbook 'composer', '~> 2.0.0'
cookbook 'drush', git: "https://github.com/msonnabaum/chef-drush.git"
cookbook 'nginx'
cookbook 'ohai'
cookbook 'openssl'
cookbook 'percona'
cookbook 'php'
cookbook 'postfix'
cookbook 'phpmd'
cookbook 'phpcpd'
cookbook 'phing'
cookbook 'mysql'
cookbook 'xdebug'
cookbook 'imagemagick'
cookbook 'git'
cookbook 'dovecot'
cookbook 'htop'

Dir.glob('./cookbooks/*').each do |path|
  cookbook File.basename(path), :path => path
end
