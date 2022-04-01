variable "proxmox_node" {
  type        = string
  default     = "pve"
  description = "Which node in the Proxmox cluster to start the virtual machine on during creation"
}
