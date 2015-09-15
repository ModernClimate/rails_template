# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.ssh.forward_agent = true

  #
  # Development
  #
  config.vm.define :development do |dev|
    # TODO: This needs to be dynamic. Use a template to generate Vagrantfile???
    dev.vm.synced_folder ".", "/home/vagrant/natcam_data_service"

    dev.vm.box = "ubuntu/trusty64"
    dev.vm.box_url = "http://files.vagrantup.com/trusty64.box"
    dev.vm.network :private_network, ip: "33.33.33.33"
    dev.vm.network "forwarded_port", guest: 3000, host: 3000

    dev.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    dev.vm.provision :ansible do |ansible|
      ansible.playbook = "provisioning/site.yml"
      ansible.inventory_path = "provisioning/inventories/development"
      ansible.verbose = "vvvv"
      ansible.sudo = true
      # TODO: This needs to be dynamic. Use a template to generate Vagrantfile???
      ansible.extra_vars = {
        app_name: "natcam_data_service"
      }
    end
  end

end
