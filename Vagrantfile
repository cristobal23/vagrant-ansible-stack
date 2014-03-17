# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define :web do |web|
    web.vm.box = "base"
    web.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", "512"]
      v.name = "WEB"
    end
    web.vm.network :private_network, ip: "192.168.56.10"
    web.vm.hostname = "web"
  end

  config.vm.define :nfs do |nfs|
    nfs.vm.box = "base"
    nfs.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", "512"]
      v.name = "NFS"
    end
    nfs.vm.network :private_network, ip: "192.168.56.20"
    nfs.vm.hostname = "nfs"
  end

  config.vm.define :rmq do |rmq|
    rmq.vm.box = "base"
    rmq.vm.provider :virtualbox do |v|
      v.boot_mode = :headless
      v.customize ["modifyvm", :id, "--memory", "512"]
      v.name = "RMQ"
    end
    rmq.vm.network :private_network, ip: "192.168.56.30"
    rmq.vm.hostname = "rmq"
  end

  config.vm.define :sql do |sql|
    sql.vm.box = "base"
    sql.vm.provider :virtualbox do |v|
      v.boot_mode = :headless
      v.customize ["modifyvm", :id, "--memory", "512"]
      v.name = "SQL"
    end
    sql.vm.network :private_network, ip: "192.168.56.40"
    sql.vm.hostname = "sql"
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "provision.yml"
    ansible.inventory_path = "hosts"
    ansible.verbose = true
    ansible.sudo = true
  end

end
