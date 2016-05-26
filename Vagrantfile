# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version.
VAGRANTFILE_API_VERSION = "2"

services = {
  "web" => "192.168.56.10",
  "nfs" => "192.168.56.20",
  "rmq" => "192.168.56.30",
  "sql" => "192.168.56.40"
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.boot_timeout=600
  # Side-step Vagrant 1.7 security feature
  config.ssh.insert_key = false

  services.each do |name, ip|
    config.vm.define name do |machine|
      machine.vm.box = "nrel/CentOS-6.5-x86_64"
      machine.vm.hostname = "%s.stack.local" % name
      unless (defined?(machine.hostsupdater)).nil?
        machine.hostsupdater.aliases = ["%s" % name]
      end
      machine.vm.network :private_network, ip: ip
      machine.vm.provider :virtualbox do |v|
        v.name = name
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
        v.customize ["modifyvm", :id, "--memory", "512"]
        v.customize ["modifyvm", :id, "--ioapic", "on"]
        v.customize ["modifyvm", :id, "--cpus", "1"]
      end
      machine.vm.synced_folder ".", "/vagrant", type: "nfs", nfs_udp: false
      machine.vm.provision :shell, inline: "if [ ! $(grep single-request-reopen /etc/sysconfig/network) ]; then echo RES_OPTIONS=single-request-reopen >> /etc/sysconfig/network && service network restart; fi"
    end
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "provision.yml"
    ansible.inventory_path = "hosts"
    ansible.host_key_checking = false
    ansible.verbose = 'vvvv'
    ansible.sudo = 'true'
    ansible.extra_vars = { ansible_ssh_user: 'vagrant',
                           ansible_connection: 'ssh',
                           ansible_ssh_args: '-o ForwardAgent=yes -i ~/.vagrant.d/insecure_private_key'}
  end

end
