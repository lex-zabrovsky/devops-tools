# Terrafrom Module Proxmox VM Provisioner

Provisons VMs on Proxmox VE via Terraform. Outputs K8s cluster configuration for RKE CLI bootstrap tool.

## Prerequisites

- A cloud-init VM template at Proxmox VE.
- Proxmox user with VM.Allocate, VM.Clone, Datastore.Allocate, Datastore.Audit, SDN.Use permissions.

## Usage

### Provisioning example

```shell
cd envs/env_name
cp .env.example .env # fill in credentials
source .env
terraform init
terraform plan
terraform apply
```

### Destroying example

Bulk destroy:

```shell
cd envs/env_name
source .env
terraform destroy
```

Destroy particular resource:

```shell
cd envs/env_name
source .env
terraform state list
terraform destroy \
  --target='module.vms["<VM-NAME>"].proxmox_virtual_environment_vm.vm'
```

## Adding a New Environment

Copy `envs/env_name/` to `envs/new_env_name/`, update `.env` and `terraform.tfvars`.

## VM Configuration Example

Edit `envs/env_name/terraform.tfvars` to setup the desired configuration. See
`envs/env_name/terraform.tfvars.example` for reference.

## TODOs

1. Refactor hardcoded netmask in `./modules/mv/main.tf:49`.
2. Support `--cpu host, --agent 1` qm options upon VM instantiation. Make them
configurable via `./envs/env-name/terraform.tfvars`.
3. Parametrize username and accesskey for cloudinit.