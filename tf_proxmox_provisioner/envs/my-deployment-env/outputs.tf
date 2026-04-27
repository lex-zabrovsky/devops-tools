# Output VM information for Ansible inventory
output "vm_inventory" {
  description = "VM inventory data for Ansible"
  value = {
    for vm_name, vm_config in var.vms : vm_name => {
      hostname     = vm_config.hostname
      vm_id        = vm_config.vm_id
      ip_address   = vm_config.networks[0].ip
      roles        = lookup(vm_config, "k8s_roles", [])
      ansible_user = "rke"
    }
  }
}

# Generate Ansible inventory file
resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../../ansible/inventory/hosts.yml"
  content = templatefile("${path.module}/../../templates/ansible_inventory.yml.tpl", {
    vms = var.vms
  })

  depends_on = [module.vms]
}

# Generate RKE cluster.yml
resource "local_file" "rke_cluster_config" {
  filename = "${path.module}/../../ansible/rke/cluster.yml"
  content = templatefile("${path.module}/../../templates/rke_cluster.yml.tpl", {
    vms                = var.vms
    kubernetes_version = var.kubernetes_version
    ssh_key_path       = var.rke_ssh_key_path
  })

  depends_on = [module.vms]
}
