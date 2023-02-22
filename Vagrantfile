# -*- mode: ruby -*-
# vi: set ft=ruby :

# https://gist.github.com/roblayton/c629683ca74658412487
vms = {
  "controller" => { :ip => "10.0.0.9",  :cpus => 2, :mem => 2048, :ssh_port => 60209 },
  "master-01"  => { :ip => "10.0.0.10", :cpus => 2, :mem => 2048, :ssh_port => 60210, :k8s_port => 6443, :k8s_port_local => 6443 },
  "node-01"    => { :ip => "10.0.0.11", :cpus => 4, :mem => 4096, :ssh_port => 60211 },
  "node-02"    => { :ip => "10.0.0.12", :cpus => 4, :mem => 4096, :ssh_port => 60212 },
  "node-03"    => { :ip => "10.0.0.13", :cpus => 4, :mem => 4096, :ssh_port => 60213 },
}


Vagrant.configure("2") do |config|

  vms.each_with_index do |(hostname, cfg), index|
    config.vm.define hostname do |vm|

      vm.vm.box = "centos/7"
      vm.vm.hostname = hostname

      vm.vm.provider :virtualbox do |vb|
        vb.name = hostname
        vb.memory = "#{cfg[:mem]}"
        vb.cpus = "#{cfg[:cpus]}"
      end

      vm.vm.network "private_network",
      auto_config: false,
      ip: "#{cfg[:ip]}"

      vm.vm.network "forwarded_port",
      protocol: "tcp",
      guest: 22,
      host: "#{cfg[:ssh_port]}"

      if ! "#{cfg[:k8s_port]}".empty?
        vm.vm.network "forwarded_port",
        protocol: "tcp",
        guest: "#{cfg[:k8s_port]}",
        host: "#{cfg[:k8s_port_local]}"
      end

      vm.vm.synced_folder ".", "/vagrant", disabled: true

      vm.vm.provision "shell", inline: "ip addr add #{cfg[:ip]}/24 dev eth1"

    end
  end

  config.trigger.after :up do |trigger|
    trigger.only_on = "#{vms.to_a.last}"
    trigger.run = { path: "vagrant.sh" }
  end
end