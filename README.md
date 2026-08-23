# Automation
A few simple [ansible](https://docs.ansible.com) roles I use on my home network and VPS's.

# Getting Started
* Clone this repo: ```git clone https://github.com/binarypenguin/automation.git```
* Create an inventory if you desire. Each inventory (```hosts```) can be a sub directory of ```inventories```. Localhost already exists if you just want to run against your local machine. (See [Ansible Inventory](http://docs.ansible.com/ansible/intro_inventory.html))
* Have a look at ```playbook.yml``` for groups that are available and the roles that are applied to them
* It's recommended to run Ansible from in a virtualenv.
  * ```cd automation```
  * ```virtualenv venv```
  * ```source venv/bin/activate```
  * ```pip install -r requirements.txt```
  * Now you have ansible ready for use, just run: ```ansible-playbook playbook.yml -i inventories/localhost```
  * When you are done, you can exit the virutalenv: ```deactivate```

# Roles
## Common
Installs a few common utilities on each machine.

## Workstation
Installs Workstation only application.

## Updating Python dependencies

Direct dependencies are maintained in `requirements.in`. The fully pinned `requirements.txt` file is generated with [`pip-tools`](https://pip-tools.readthedocs.io/) and should not be edited manually.

To update all dependencies:

```bash
python -m pip install --upgrade pip pip-tools
pip-compile --upgrade requirements.in
python -m pip install --upgrade -r requirements.txt
```

Commit both `requirements.in` and the regenerated `requirements.txt`.
