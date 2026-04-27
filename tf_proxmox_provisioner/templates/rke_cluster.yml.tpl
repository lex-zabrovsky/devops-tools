# Auto-generated RKE cluster configuration from Terraform
# DO NOT EDIT MANUALLY - This file is managed by Terraform

kubernetes_version: "${kubernetes_version}"

nodes:
%{ for vm_name, vm_config in vms ~}
%{ if length(lookup(vm_config, "k8s_roles", [])) > 0 ~}
- address: "${vm_config.networks[0].ip}"
  role: ${jsonencode(lookup(vm_config, "k8s_roles", []))}
  user: "rke"
  ssh_key_path: "${ssh_key_path}"
  hostname_override: ${vm_config.hostname}
%{ endif ~}
%{ endfor ~}

services:
  kube-api:
    service_cluster_ip_range: 10.43.0.0/16
  kube-controller:
    cluster_cidr: 10.42.0.0/16
    service_cluster_ip_range: 10.43.0.0/16
  kubelet:
    fail_swap_on: false

private_registries:
  - url: oss.registry:5000
    user: admin
    password: admin
    is_default: true

ssh_key_path: "${ssh_key_path}"
