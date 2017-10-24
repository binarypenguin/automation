#!/bin/bash
ansible-playbook playbook.yml -i inventories/production --become --ask-vault-pass $@
