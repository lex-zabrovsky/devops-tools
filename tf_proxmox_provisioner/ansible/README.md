# Infrastructure Configuration Repo

This repository contains Ansible playbook to bootsrap K8s cluster and install
Rancher Manager GUI and required dependencies.

## Prerequisites

1. Infrastructure provisioned.
2. `private.registry` private container image repository installed.
3. Service user `rke` authenticated in `private.registry` repository.
4. `private.registry` repository contains all images required.

## Usage

Configure variables in `inventory` file.

Deploy all services:

```shell
ansible-playbook playbooks/k8s_bootstrap_and_rancher_deploy.yml \
  -e "cluster_config_path=/rke/cluster.yml" -i ./inventory
```

Bootstrap K8s cluster only:

```shell
ansible-playbook playbooks/k8s_bootstrap_and_rancher_deploy.yml --tags "rke" \
  -e "cluster_config_path=/rke/cluster.yml" -i ./inventory
```
