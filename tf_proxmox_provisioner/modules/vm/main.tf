terraform {
  required_version = ">= 0.12"
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  vm_id     = var.vm_id
  name      = var.vm_name
  node_name = var.target_node

  clone {
    vm_id = var.template_id
  }

  cpu {
    cores = var.cpu
  }

  memory {
    dedicated = var.ram
  }

  dynamic "network_device" {
    for_each = var.networks
    content {
      bridge = network_device.value.bridge
    }
  }

  dynamic "disk" {
    for_each = var.disks
    content {
      datastore_id = disk.value.storage
      size = disk.value.size
      interface = "scsi${disk.key}"
    }
  }

  # WARNING: netmask hardcoded
  initialization {
    dynamic "ip_config" {
      for_each = var.networks
      content {
        ipv4 {
          address = ip_config.value.ip == "dhcp" ? "dhcp" : "${ip_config.value.ip}/24"
          gateway = ip_config.value.ip == "dhcp" ? null : ip_config.value.gateway
        }
      }
    }

    user_data_file_id = null

    datastore_id = var.disks[0].storage
  }

  # Wait for cloud-init to complete
  started = true
  
  # Graceful stop of VM on destroy
  stop_on_destroy = true

  lifecycle {
    ignore_changes = [
      started,
    ]
  }
}
