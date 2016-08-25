# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  config.vm.define "ubuntu16web" do |ubuntuweb|
    ubuntuweb.vm.box = "ubuntu/xenial64"
    ubuntuweb.vm.hostname = "ubuntu16web"

    ubuntuweb.vm.provider "virtualbox" do |vb|
      vb.name = "automation_ubuntu16web"
    end

    ubuntuweb.vm.provision "shell", inline: "apt-get install -y python2.7 hostname"
    ubuntuweb.vm.provision "ansible" do |ansible|
      ansible.verbose = "v"
      ansible.host_key_checking = false
      ansible.playbook = "playbook.yml"
      ansible.groups = {
          "web" => ["ubuntu16web"]
      }
      ansible.extra_vars = {
        ansible_python_interpreter: "/usr/bin/python2.7"
      }
    end
  end

  config.vm.define "ubuntu16db" do |ubuntudb|
    ubuntudb.vm.box = "ubuntu/xenial64"
    ubuntudb.vm.hostname = "ubuntu16db"

    ubuntudb.vm.provider "virtualbox" do |vb|
      vb.name = "automation_ubuntu16db"
    end

    ubuntudb.vm.provision "shell", inline: "apt-get install -y python2.7 hostname"
    ubuntudb.vm.provision "ansible" do |ansible|
      ansible.verbose = "v"
      ansible.host_key_checking = false
      ansible.playbook = "playbook.yml"
      ansible.groups = {
          "database" => ["ubuntu16db"]
      }
      ansible.extra_vars = {
        ansible_python_interpreter: "/usr/bin/python2.7"
      }
    end
  end

  config.vm.define "fedora" do |fedora|
    fedora.vm.box = "fedora/23-cloud-base"
    fedora.vm.hostname = "fedora"

    fedora.vm.provider "virtualbox" do |vb|
      vb.name = "automation_fedora"
    end

    fedora.vm.provision "shell", inline: "dnf install -y python2 python2-dnf libselinux-python"
    fedora.vm.provision "ansible" do |ansible|
      ansible.verbose = "v"
      ansible.host_key_checking = false
      ansible.playbook = "playbook.yml"
      ansible.extra_vars = {
        ansible_python_interpreter: "/usr/bin/python2"
      }
    end
  end

  config.vm.define "arch" do |arch|
    arch.vm.box = "terrywang/archlinux"
    arch.vm.hostname = "arch"

    arch.vm.provider "virtualbox" do |vb|
      vb.name = "automation_arch"
    end

    arch.vm.provision "ansible" do |ansible|
      ansible.verbose = "v"
      ansible.host_key_checking = false
      ansible.playbook = "playbook.yml"
      ansible.extra_vars = {
        ansible_python_interpreter: "/usr/bin/python2"
      }
    end
  end
end
