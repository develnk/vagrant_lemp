Vagrant commands:
vagrant ssh - connect to virtual machine
vagrant up = create / start virtual machine
vagrant provision = install / update settings of virtual machine
vagrant reload = restart virtual machine
vagrant suspend = stop virtual machine
vagrant destroy = delete virtual machine

Structure files:
/vagrant - the shared folder
/var/www/site_name - the folder with git repository files (default site_name = site)
/var/www/site_name/project - the site folder

Needed Software:
1. VirtualBox - https://www.virtualbox.org/
2. Vagrant - http://www.vagrantup.com/
3. For Windows:
3.1. Dokan Library - http://dokan-dev.net/en/download/
3.2. Win SSHfs - https://code.google.com/p/win-sshfs/
or
3.3 SFTP Net Drive - https://www.eldos.com/sftp-net-drive/download-release.php
4. For Unix/Mac:
4.1. Vagrant SSHfs - https://github.com/fabiokr/vagrant-sshfs
