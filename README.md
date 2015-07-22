# Automation
A few simple ansible roles I use on my home network and VPS's.

#Getting Started
* Clone this repo
* Copy ```hosts.example``` to ```hosts```
* Update ```hosts``` with machines you would like to provision. (See [Ansible Inventory](http://docs.ansible.com/ansible/intro_inventory.html))
  * Have a look at ```site.yml``` for groups that are available and the roles that are applied to them
* Run ```./bootstrap.sh``` to install the prerequisites needed.
* Run ```./run.sh``` to provision your hosts :)

#Contributing
* Ensure you have [Vagrant](https://www.vagrantup.com/)
* Clone this repo
* Run ```./bootstrap.sh``` to install the prerequisites needed.
* ```vagrant up``` to generate the VM
* ```vagrant provision``` to re-provision your test VM
* Create a pull request

#Roles
## Common
Installs a few common utilities on each machine.

## Bastion
Sets up UFW. More coming soon.

## Composer
Installs [Composer](https://getcomposer.org/)

## Workstation
Installs Workstation only application.
