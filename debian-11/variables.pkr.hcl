variable "proxmox_api" {
  type        = string
  default     = "https://example.com/api2/json"
  description = "URL to the Proxmox API, including the full path"
}

variable "proxmox_node" {
  type        = string
  default     = "pve"
  description = "Which node in the Proxmox cluster to start the virtual machine on during creation"
}

variable "proxmox_username" {
  type        = string
  sensitive   = true
  description = "Username when authenticating to Proxmox, including the realm"
}

variable "proxmox_token_id" {
  type        = string
  sensitive   = true
  description = "Token ID for authenticating API calls"
}

variable "proxmox_token_secret" {
  type        = string
  sensitive   = true
  description = "Token Secret for authenticating API calls"
}
