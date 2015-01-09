#   Install with command

REQUIRED_PLUGINS = %w(vagrant-hostsupdater vagrant-omnibus)
exit unless REQUIRED_PLUGINS.all? do |plugin|
  Vagrant.has_plugin?(plugin) || (
  puts "The #{plugin} plugin is required. Please install it with:"
  puts "$ vagrant plugin install #{plugin}"
  false
  )
end


Vagrant.configure("2") do |config|
  config.vm.box = "vagrant-ubuntu14.10"
  config.vm.box_url = "/home/develnk/virtual/box/ubuntu-14.10.box"
  config.vm.network :forwarded_port, host: 4567, guest: 4567

  config.vm.define "webserver" do |machine|
    # machine.hostsupdater.aliases = ["drupal.dev"]
    machine.berkshelf.enabled = false

    machine.vm.provider :virtualbox do |vb, override|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "60"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

    machine.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["cookbooks", "chef/applications"]
      chef.roles_path = "chef/roles"
      chef.add_role "webserver"

      chef.add_recipe "apt"
      chef.add_recipe "phpapp"
      chef.add_recipe "phing"
      chef.add_recipe "phpmd"
      chef.add_recipe "phpcpd"

      # Configure available sites. For each site directory should be created in /var/www.
      chef.json = {
          "project" => {
              "sites" => {
                  "demo" => 4567,
              }
          }
      }
    end
  end
end
