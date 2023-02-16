# -*- mode: ruby -*-
# vi: set ft=ruby :

# https://blog.scottlowe.org/2016/01/14/improved-way-yaml-vagrant/
require 'yaml'
vms = YAML.load_file(File.join(File.dirname(__FILE__), 'vagrant.yaml'))
last_vm = vms.last["name"]

Vagrant.configure("2") do |config|

  vms.each do |vms|
    config.vm.define vms["name"] do |vm|
      vm.vm.box = vms["box"]
      vm.vm.network "private_network", ip: vms["ip"]
      vm.vm.hostname = vms["name"]
      vm.vm.network "forwarded_port", guest: 22, host: vms["ssh_port"], protocol: "tcp"
      vm.vm.synced_folder ".", "/vagrant", disabled: true

      vm.vm.provider :virtualbox do |vb|
        vb.name = vms["name"]
        vb.memory = vms["mem"]
        vb.cpus = vms["cpu"]
      end
      vm.vm.provision "shell",
        #inline: "ip route del default && echo DEFROUTE=\"no\" >> /etc/sysconfig/network-scripts/ifcfg-eth0"
        inline: "echo 'skipping'"
    end



  end

  # Execute k8s kubeadm install
  config.trigger.after :up do |trigger|

    trigger.only_on = "node-03"
    trigger.name = "host-trigger"
    trigger.info = "Attempting to prepare vagrant VMs"
    trigger.run  = { inline: "ansible-playbook playbook.yaml" }
  end


end

  # config.vm.define "control" do |control|
  #   control.vm.box = VM_BOX
  #   control.vm.network "private_network", ip: "10.0.0.9"
  #   #control.vm.network "forwarded_port", guest: 22, host: 60200, protocol: "tcp"
  #   #control.vm.network "forwarded_port", guest: 6443, host: 6443, protocol: "tcp"
  #   # Uncomment to get and IP from your DHCP - ie. at home
  #   # https://www.vagrantup.com/docs/networking/public_network
  #   #config.vm.network "public_network", bridge: "eno1"
  #   control.vm.hostname = "control"

  #   control.vm.provider :virtualbox do |vb|
  #     vb.customize ["modifyvm", :id, "--memory", "1024" ]
  #     vb.customize ["modifyvm", :id, "--cpus", "2" ]
  #     end
  #   control.vm.synced_folder "/Users/eb/Projects", "/host/eb/Projects"
  # end

  # config.vm.define "master-01" do |node01|
  #   mas01.vm.box = VM_BOX
  #   node01.vm.network "private_network", ip: "10.0.0.10"
  #   #node01.vm.network "forwarded_port", guest: 22, host: 60201, protocol: "tcp"
  #   node01.vm.hostname = "master-01"

  #  node01.vm.provider :virtualbox do |vb|
  #     vb.customize ["modifyvm", :id, "--memory", "4096" ]
  #     vb.customize ["modifyvm", :id, "--cpus", "4" ]
  #     end
  #  node01.vm.synced_folder "/Users/eb/Projects", "/host/eb/Projects"
  #  end


  # config.vm.define "node-01" do |node02|
  #   node02.vm.box = VM_BOX
  #   node02.vm.network "private_network", ip: "10.0.0.11"
  #   #node02.vm.network "forwarded_port", guest: 22, host: 60202, protocol: "tcp"

  #   node02.vm.hostname = "node-01"

  #   node02.vm.provider :virtualbox do |vb|
  #     vb.customize ["modifyvm", :id, "--memory", "4096" ]
  #     vb.customize ["modifyvm", :id, "--cpus", "4" ]
  #     end
  #   node02.vm.synced_folder "/Users/eb/Projects", "/host/eb/Projects"
  # end

  # config.vm.define "node-02" do |node02|
  #   node02.vm.box = VM_BOX
  #   node02.vm.network "private_network", ip: "10.0.0.11"
  #   #node02.vm.network "forwarded_port", guest: 22, host: 60202, protocol: "tcp"

  #   node02.vm.hostname = "node-02"

  #   node02.vm.provider :virtualbox do |vb|
  #     vb.customize ["modifyvm", :id, "--memory", "4096" ]
  #     vb.customize ["modifyvm", :id, "--cpus", "4" ]
  #     end
  #   node02.vm.synced_folder "/Users/eb/Projects", "/host/eb/Projects"
  # end


  # # Execute k8s kubeadm install
  # config.trigger.after :up do |trigger|
  #   trigger.only_on = "node-02"
  #   trigger.name = "ansible trigger"
  #   trigger.info = "Attempting to run ./vagrant-k8s.sh"
  #   trigger.run  = { path: "vagrant-k8s.sh" }
#   end

# end
