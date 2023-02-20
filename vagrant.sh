#!/usr/bin/env bash
set -euo pipefail
pp='\033[0;35m' #purple
nc='\033[0m'    #no color

if [ ! "${NO_TRIGGERS:-}" ]; then
    printf "${pp}# prepping vagrant VMs${nc}\n"
    ansible-playbook vagrant-site.yaml

    printf "${pp}# running rke2-ansible on a controller VM${nc}\n"
    vagrant ssh controller -c 'cd ./rke2-ansible && ansible-playbook site.yml -v'

    printf "${pp}## FINISHED ##${nc}\n"
else
    printf "${pp}NO_TRIGGERS is set. Skipping provisioning.${nc}\n"
fi