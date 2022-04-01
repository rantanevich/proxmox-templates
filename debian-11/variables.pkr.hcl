variable "proxmox_node" {
  type        = string
  default     = env("PROXMOX_NODE")
  description = "Which node in the Proxmox cluster to start the virtual machine on during creation"
}
