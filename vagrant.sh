#!/usr/bin/env bash
set -euo pipefail
pp='\033[0;35m' #purple
nc='\033[0m\n'  #no color + newline

if [ "${VAGRANT_TRIGGER:-}" == "false" ]
  then
    printf "%bVAGRANT_TRIGGER is false. Skipping provisioning.%b" "${pp}" "${nc}"
  else
    printf "%b# prepping vagrant VMs%b" "${pp}" "${nc}"
    ansible-playbook vagrant-site.yaml

    # printf "%b# installing rke2-ansible via controller VM%b" "${pp}" "${nc}"
    # vagrant ssh controller -c 'cd ./rke2-ansible && ansible-playbook site.yml -v'

    # printf "%b# saving master-01 kubeconfig to /tmp/rke2-ansible.yaml%b" "${pp}" "${nc}"
    # ansible ,master-01 -b -m fetch -a 'src=/etc/rancher/rke2/rke2.yaml dest=/tmp/rke2-ansible.yaml flat=yes'

    # printf "%b# accessing master-01 to check nodes status ready%b" "${pp}" "${nc}"
    # vagrant ssh master-01 -c 'sudo /var/lib/rancher/rke2/bin/kubectl --kubeconfig /etc/rancher/rke2/rke2.yaml wait node --all --for condition=ready --timeout=300s'

    printf "%b## FINISHED ##%b" "${pp}" "${nc}"
fi