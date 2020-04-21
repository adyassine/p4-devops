# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    # serveur dev
    config.vm.define "docker-pipeline" do |config|
        config.vm.box = "debian/buster64"
        config.vm.network "forwarded_port", guest: 80, host: 80
        config.vm.network :private_network, ip: "192.168.10.10"
        config.vm.hostname = "devops-app"
        config.vm.provision :shell, :path => "provision.sh"
    end

    # Serveur gitlab
    config.vm.define "gitlab-pipeline" do |gitlab|
        gitlab.vm.box = "debian/buster64"
        gitlab.vm.hostname = "gitlab-pipeline"
        gitlab.vm.box_url = "debian/buster64"
        gitlab.vm.network :private_network, ip: "192.168.10.20"
        gitlab.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            v.customize ["modifyvm", :id, "--memory", 2048]
            v.customize ["modifyvm", :id, "--name", "gitlab-pipeline"]
            v.customize ["modifyvm", :id, "--cpus", "1"]
        end
        config.vm.provision "shell", inline: <<-SHELL
            sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
            service ssh restart
        SHELL
        gitlab.vm.provision "shell", path: "install_gitlab.sh"
    end

    # Build docker image
    config.vm.provision :docker do |docker|
        #docker.build_image '/vagrant/p3-devops.com/', args: '-t web'
        #docker.run 'web', args: '-it -p 8080:80'
    end
end
