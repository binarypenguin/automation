# Automation
A few simple ansible roles I use on my home network and VPS's.

#Dependencies
* Ansible =< 2.2

#Getting Started
* [Install Ansible](http://docs.ansible.com/ansible/intro_installation.html#latest-releases-via-apt-ubuntu)
* Clone this repo: ```git clone https://github.com/binarypenguin/automation.git```
* Copy ```hosts.example``` to ```hosts```
* Update ```hosts``` with machines you would like to provision. (See [Ansible Inventory](http://docs.ansible.com/ansible/intro_inventory.html))
  * Have a look at ```site.yml``` for groups that are available and the roles that are applied to them
  * If you are setting up virtual hosts using the web/common role, see the [example!](host_vars/example)
* ```ansible-galaxy install -r requirements.txt``` to install third party modules.
* Run ```./provision.sh``` to provision your hosts :)

#Roles
## Common
Installs a few common utilities on each machine.

## Bastion
Sets up UFW. More coming soon.

## Composer
Installs [Composer](https://getcomposer.org/)

## Workstation
Installs Workstation only application.

## Web / Common
Sets up Nginx and php-fpm. It allows for team based projects.
