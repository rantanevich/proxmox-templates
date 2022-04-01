variable "proxmox_api" {
  type    = string
  default = "https://example.com/api2/json"
}

variable "proxmox_node" {
  type    = string
  default = "pve"
}

variable "proxmox_username" {
  type      = string
  sensitive = true
}

variable "proxmox_password" {
  type      = string
  sensitive = true
}
