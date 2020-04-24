# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "debian/buster64"
    config.vm.network "private_network", ip: "192.168.33.20"
    config.vm.hostname = "gitlab"
    config.vm.provider :virtualbox do |v|
        v.memory = 2048
        v.cpus = 2
    end
    #config.vm.provision "shell", path: "provision.sh"
end
