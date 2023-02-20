#!/usr/bin/env bash
set -euo pipefail
pp='\033[0;35m' #purple
nc='\033[0m'    #no color

if [ ! "${NO_TRIGGERS:-}" ]; then
    printf "${pp}# prepping vagrant VMs${nc}\n"
    ansible-playbook vagrant-site.yaml

    printf "${pp}# running rke2-ansible on a controller VM${nc}\n"
    vagrant ssh controller -c 'cd ./rke2-ansible && ansible-playbook site.yml -v'

    printf "${pp}# accessing master-01 to check nodes status ready${nc}\n"
    vagrant ssh master-01 -c 'sudo /var/lib/rancher/rke2/bin/kubectl --kubeconfig /etc/rancher/rke2/rke2.yaml wait node --all --for condition=ready --timeout=300s'

    printf "${pp}## FINISHED ##${nc}\n"
else
    printf "${pp}NO_TRIGGERS is set. Skipping provisioning.${nc}\n"
fi