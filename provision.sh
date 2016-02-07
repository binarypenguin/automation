#!/bin/bash
ansible-playbook playbook.yml --inventory-file=hosts --become --ask-vault-pass $@
