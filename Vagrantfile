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
    end
  end

  config.vm.define "fedora" do |fedora|
    fedora.vm.box = "fedora/23-cloud-base"

    fedora.vm.provision "ansible" do |ansible|
      ansible.verbose = "v"
      ansible.host_key_checking = false
      ansible.playbook = "playbook.yml"
    end
  end

  config.vm.define "arch" do |arch|
    arch.vm.box = "terrywang/archlinux"

    arch.vm.provision "ansible" do |ansible|
      ansible.verbose = "v"
      ansible.host_key_checking = false
      ansible.playbook = "playbook.yml"
    end
  end
end
