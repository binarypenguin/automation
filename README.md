# Automation
A few simple [ansible](https://docs.ansible.com) roles I use on my home network and VPS's.

# Dependencies
* Ansible =< v2.8.0b

# Getting Started
* Clone this repo: ```git clone https://github.com/binarypenguin/automation.git```
* Create an inventory if you desire. Each inventory (```hosts```) can be a sub directory of ```inventories```. Localhost already exists if you just want to run against your local machine. (See [Ansible Inventory](http://docs.ansible.com/ansible/intro_inventory.html))
* Have a look at ```playbook.yml``` for groups that are available and the roles that are applied to them
* Since I'm likely running a newer version than is supplied by your package manager, I recommend installing with virtualenv.
  * ```cd automation```
  * ```virtualenv venv```
  * ```source venv/bin/activate```
  * ```pip install -r requirements.txt```
  * Now you have ansible ready for use, just run: ```ansible-playbook playbook.yml -i inventories/localhost```
  * When you are done, you can exit the virutalenv: ```deactivate```

# Roles
## Common
Installs a few common utilities on each machine.

## Bastion
Sets up UFW. More coming soon.

## DNSMASQ
Setups up and manages a DNS/DHCP/TFTP server (Coming soon!).

## Tools / Composer
Installs [Composer](https://getcomposer.org/)

## Workstation
Installs Workstation only application.

## Web / Common
Sets up Nginx and php-fpm. It allows for team based projects.
