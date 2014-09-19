# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.boot_timeout=600

  config.vm.define :web do |web|
    web.vm.box = "centos6"
    web.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", "512"]
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--ioapic", "on"]
      v.customize ["modifyvm", :id, "--cpus", "1"]
      v.name = "WEB"
    end
    web.vm.network :private_network, ip: "192.168.56.10"
    web.vm.hostname = "web.stack.local"
    web.vm.synced_folder ".", "/vagrant", type: "nfs", nfs_udp: false
    web.vm.provision :shell, inline: "if [ ! $(grep single-request-reopen /etc/sysconfig/network) ]; then echo RES_OPTIONS=single-request-reopen >> /etc/sysconfig/network && service network restart; fi"
  end

  config.vm.define :nfs do |nfs|
    nfs.vm.box = "centos6"
    nfs.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", "512"]
      v.name = "NFS"
    end
    nfs.vm.network :private_network, ip: "192.168.56.20"
    nfs.vm.hostname = "nfs.stack.local"
  end

  config.vm.define :rmq do |rmq|
    rmq.vm.box = "centos6"
    rmq.vm.provider :virtualbox do |v|
      v.boot_mode = :headless
      v.customize ["modifyvm", :id, "--memory", "512"]
      v.name = "RMQ"
    end
    rmq.vm.network :private_network, ip: "192.168.56.30"
    rmq.vm.hostname = "rmq.stack.local"
  end

  config.vm.define :sql do |sql|
    sql.vm.box = "centos6"
    sql.vm.provider :virtualbox do |v|
      v.boot_mode = :headless
      v.customize ["modifyvm", :id, "--memory", "512"]
      v.name = "SQL"
    end
    sql.vm.network :private_network, ip: "192.168.56.40"
    sql.vm.hostname = "sql.stack.local"
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "provision.yml"
    ansible.inventory_path = "hosts"
    ansible.host_key_checking = false
    ansible.verbose = vvvv
    ansible.sudo = 'true'
    ansible.extra_vars = { ansible_ssh_user: 'vagrant',
                           ansible_connection: 'ssh',
                           ansible_ssh_args: '-o ForwardAgent=yes'}
  end

end
