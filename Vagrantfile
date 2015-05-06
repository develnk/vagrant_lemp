#   Install with command

REQUIRED_PLUGINS = %w(vagrant-hostsupdater vagrant-omnibus vagrant-berkshelf)
exit unless REQUIRED_PLUGINS.all? do |plugin|
  Vagrant.has_plugin?(plugin) || (
  puts "The #{plugin} plugin is required. Please install it with:"
  puts "$ vagrant plugin install #{plugin}"
  false
  )
end


Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu-15.04"
  config.vm.network :forwarded_port, host: 4567, guest: 4567

  config.vm.define "webserver" do |machine|
    # Berkshelf
    machine.berkshelf.enabled = true
    machine.berkshelf.berksfile_path = "./Berksfile"
    machine.berkshelf.only = [:default, :master]

    machine.vm.provider :virtualbox do |vb, override|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "60"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      #vb.gui = true
    end

    machine.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["cookbooks"]
      chef.roles_path = "chef/roles"
      chef.add_role "webserver"

      # Configure available sites. For each site directory should be created in /var/www.
      chef.json = {
          "project" => {
              "sites" => {
                  "site" => {
                      "port" => 4567,
                      "dir" => "/var/www/site",
                  },
                  "another_site" => {
                      "domain" => "site.com",
                  },
                  "empty_site" => {

                  }
              }
          }
      }
    end
  end
end
