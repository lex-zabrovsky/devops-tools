variable "pm_api_url" {
  type        = string
  default     = ""
  description = "Proxmox API URL (e.g., https://proxmox-server:8006/api2/json"
}

variable "pm_username" {
  type        = string
  default     = ""
  description = "Proxmox username with realm (e.g. terraform@pam"
}

variable "pm_password" {
  type        = string
  default     = ""
  description = "Proxmox user password."
}

variable "pm_target_node" {
  type        = string
  default     = ""
  description = "Proxmox node name where VMs will be created."
}

variable "pm_template_id" {
  type        = number
  description = "Numeric ID of the cloud-init VM template to clone."
}

variable "vms" {
  type        = map(object({
    hostname  = string
    vm_id     = optional(number, null)
    cpu       = number
    ram       = number
    k8s_roles = optional(list(string), [])
    networks  = list(object({
      bridge  = string
      ip      = string
      gateway = string
    }))
    disks     = list(object({
      size    = number
      storage = string
    }))
  }))
  description = "Map of VM configurations."
}

variable "kubernetes_version" {
  type        = string
  default     = "v1.24.9-rancher1-1"
  description = "Kubernetes version for RKE cluster."
}

variable "rke_ssh_key_path" {
  type        = string
  default     = "/home/rke/.ssh/rke_key"
  description = "SSH key path for RKE user."
}

