# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "ubuntu/trusty64"

    ubuntu.vm.provision "ansible" do |ansible|
      ansible.verbose = "v"
      ansible.host_key_checking = false
      ansible.playbook = "playbook.yml"
      ansible.extra_vars = {
        ansible_python_interpreter: "/usr/bin/python"
      }
    end
  end

  config.vm.define "fedora" do |fedora|
    fedora.vm.box = "fedora/23-cloud-base"
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
