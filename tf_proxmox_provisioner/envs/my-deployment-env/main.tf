module "vms" {
  source   = "../../modules/vm"
  for_each = var.vms

  vm_name = each.key
  vm_id   = each.value.vm_id

  target_node = var.pm_target_node
  template_id = var.pm_template_id

  hostname = each.value.hostname
  cpu      = each.value.cpu
  ram      = each.value.ram
  networks = each.value.networks
  disks    = each.value.disks
}