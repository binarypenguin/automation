#!/bin/bash
ansible-playbook playbook.yml -i production --become --ask-vault-pass $@
