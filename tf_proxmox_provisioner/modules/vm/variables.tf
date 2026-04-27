variable "vm_name" {
  type        = string
  default     = ""
  description = "VM name/inedtifier"
}

variable "vm_id" {
  type        = number
  default     = null
  description = "Proxmox VM ID. If null, Proxmox auto-assigns."
}

variable "hostname" {
  type        = string
  default     = ""
  description = "VM hostname"
}

variable "target_node" {
  type        = string
  default     = ""
  description = "Proxmox VE node name."
}

variable "template_id" {
  type        = number
  description = "Template VM ID to clone from."
}

variable "cpu" {
  type        = number
  description = "Number of CPU cores."
}

variable "ram" {
  type        = number
  description = "RAM in MB."
}

variable "networks" {
  type        = list(object({
    bridge  = string
    ip      = string
    gateway = string
  }))
  description = "List of network configuration with IP settings."
}

variable "disks" {
  type        = list(object({
    size = number
    storage = string
  }))
  description = "List of disk configurations."
}


