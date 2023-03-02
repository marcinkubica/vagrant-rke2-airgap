#!/usr/bin/env bash
set -o pipefail

vm_boxes=(
    generic/rocky8
    # centos/7
    # centos/8
    # centos/stream8
    # generic/rhel7
    # generic/rhel8
)

for vm in "${vm_boxes[@]}"; do

vbox_name="$( echo ${vm} | tr '/' '-')"
test_name="./testing/test-${vbox_name}"
export VM_BOX=${vm}

echo "# ----------------"
echo "# vm_box is ${VM_BOX}"

echo "# deleting the log"
    rm -f ${test_name}*

echo "# vagrant destroy"
    vagrant destroy -f  |& tee "${test_name}"

echo "# vagrant up"
    vagrant up |& tee -a "${test_name}"



if [ $? -ne 0 ]; then
    mv "${test_name}" "${test_name}-failed.log"
    else
    mv "${test_name}" "${test_name}-passed.log"
fi

echo "# FINISHED"

done