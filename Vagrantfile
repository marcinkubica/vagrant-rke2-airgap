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
    end
  end

  config.trigger.after :up do |trigger|
    trigger.only_on = "node-03"
    trigger.run = { path: "vagrant.sh" }
  end
end