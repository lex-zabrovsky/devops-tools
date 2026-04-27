---
# Auto-generated Ansible inventory from Terraform
# DO NOT EDIT MANUALLY - This file is managed by Terraform

all:
  vars:
    ansible_user: rke
    ansible_ssh_private_key_file: /home/rke/.ssh/rke_key
    ansible_python_interpreter: /usr/bin/python3

  children:
    k8s_cluster:
      children:
        k8s_masters:
          hosts:
%{ for vm_name, vm_config in vms ~}
%{ if contains(lookup(vm_config, "k8s_roles", []), "controlplane") ~}
            ${vm_config.hostname}:
              ansible_host: ${vm_config.networks[0].ip}
              proxmox_vmid: ${vm_config.vm_id}
              k8s_roles: ${jsonencode(lookup(vm_config, "k8s_roles", []))}
%{ endif ~}
%{ endfor ~}

        k8s_workers:
          hosts:
%{ for vm_name, vm_config in vms ~}
%{ if contains(lookup(vm_config, "k8s_roles", []), "worker") ~}
            ${vm_config.hostname}:
              ansible_host: ${vm_config.networks[0].ip}
              proxmox_vmid: ${vm_config.vm_id}
              k8s_roles: ${jsonencode(lookup(vm_config, "k8s_roles", []))}
%{ endif ~}
%{ endfor ~}

        k8s_etcd:
          hosts:
%{ for vm_name, vm_config in vms ~}
%{ if contains(lookup(vm_config, "k8s_roles", []), "etcd") ~}
            ${vm_config.hostname}:
              ansible_host: ${vm_config.networks[0].ip}
              proxmox_vmid: ${vm_config.vm_id}
              k8s_roles: ${jsonencode(lookup(vm_config, "k8s_roles", []))}
%{ endif ~}
%{ endfor ~}

    rke_control:
      hosts:
        localhost:
          ansible_connection: local
          ansible_python_interpreter: "{{ ansible_playbook_python }}"
