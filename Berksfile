source "https://supermarket.chef.io"

metadata

cookbook 'apt'
cookbook 'chef-client', '> 3.0'
cookbook 'nginx'
cookbook 'ohai'
cookbook 'openssl'
cookbook 'php'
cookbook 'postfix'
cookbook 'phpmd'
cookbook 'phpcpd'
cookbook 'phing'
cookbook 'xdebug'
cookbook 'imagemagick'
cookbook 'git'
cookbook 'dovecot'
cookbook 'htop'

Dir.glob('./cookbooks/*').each do |path|
  cookbook File.basename(path), :path => path
end
