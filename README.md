# vagrant-rke2-airgap

An attempt to install and play with [Rancher RKE2 air-gapped](https://github.com/rancherfederal/rke2-ansible) installation

## Usage

```
vagrant up
```

To skip provisioning and just bring up the VMs:

```
VAGRANT_TRIGGER=false vagrant up
```

To skip configuring airgap:
```
ANSIBLE_AIRGAP=false vagrant up
```

## Requirements

- vagrant
- virtualbox
- ansible

## TLDR;
![](./vagrant.svg)

Vagrant will perform the following:
- provision VMs as defined in [vagrant.yaml](./vagrant.yaml)
- execute ansible on your machine:
  - pre-onfigure vagrant VMs
  - prepare RKE2 airgap install with rke2 linux images
  - generate `my-cluster` inventory for rke2-ansible
- execute ansible on air-gapped controller machine:
  - install rke2 on all air-gapped cluster VMs

## Accessing RKE2 from your host
1. An alias to `kubectl` is created on a master server
    ```
    alias kubectl='sudo /var/lib/rancher/rke2/bin/kubectl --kubeconfig /etc/rancher/rke2/rke2.yaml'
    ```

1. Port 6443 is forwarded by default from master-01 to localhost
1. RKE2's `/etc/rancher/rke2/rke2.yaml` kubeconfig file is saved to `/tmp/rke2-ansible.yaml` \
   Using this file is sufficient to connect from localhost with your favourite k8s tool.

## TODOS:
1. Support more linux os (currently only centos7 😆 )
1. Add docker registry
1. Support private repository install method


## Stuff used

* intel OSX ventura (my host OS) - should easily run on your Linux laptop (or maybe even on Windows)
* vagrant 2.3.4
* virtualbox 7.04
* ansible 2.14.1

## Notes
1. Since there's a [config.yaml bug in rancherfederal/rke2-ansible](https://github.com/rancherfederal/rke2-ansible/issues/138) at present the git repo being pulled is using my rke2-ansible fork

1. Virtualbox on OSX by default might not allow you to create required interfaces.\
   Try creating the following file `/etc/vbox/networks.conf`
   ```
   * 10.0.0.0/8 192.168.0.0/16
   ```

1. There might be funky things going on if you use M1/M2 Apples

1. Completion time: ~22mins (on my laptop 😉) also see [the transcript file](./vagrant.log).