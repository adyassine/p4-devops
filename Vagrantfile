# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    # serveur dev
    config.vm.define "docker-pipeline" do |config|
        config.vm.box = "debian/buster64"
        config.vm.network "private_network", ip: "192.168.33.10"
        config.vm.hostname = "devops-app"
        config.vm.provision :shell, :path => "provision.sh"
        config.vm.post_up_message = \
            "The private network IP address is: 192.168.33.10\n\n" \
            "To customize, set the host called '#{config.vm.hostname}'\n" \
            "to the desired IP address in your /etc/hosts and run \n" \
            "'vagrant reload'!\n"
    end

    # Serveur gitlab
    config.vm.define "gitlab-pipeline" do |gitlab|
        gitlab.vm.box = "debian/buster64"
        gitlab.vm.hostname = "gitlab-pipeline"
        gitlab.vm.box_url = "debian/buster64"
        gitlab.vm.network "private_network", ip: "192.168.33.20"
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

        gitlab.vm.post_up_message = \
            "The private network IP address is: 192.168.33.20\n\n" \
            "To customize, set the host called '#{gitlab.vm.hostname}'\n" \
            "to the desired IP address in your /etc/hosts and run \n" \
            "'vagrant reload'!\n"
    end
end
