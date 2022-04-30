variable "proxmox_api" {
  type        = string
  description = "URL to the Proxmox API, including the full path, so https://<server>:<port>/api2/json"
}

variable "proxmox_username" {
  type        = string
  description = "Username when authenticating to Proxmox, including the realm. When using token authentication, the username must include the token id after an exclamation mark"
}

variable "proxmox_token" {
  type        = string
  description = "Token secret for authenticating API calls"
}

variable "proxmox_node" {
  type        = string
  default     = "pve"
  description = "Which node in the Proxmox cluster to start the virtual machine on during creation"
}

variable "iso_url" {
  description = "URL to an ISO file to upload to Proxmox, and then boot from"
}

variable "iso_storage_pool" {
  default     = "local-lvm"
  description = "Proxmox storage pool onto which to upload the ISO file"
}

variable "iso_checksum" {
  description = "Checksum of the ISO file"
}

variable "vm_id" {
  default     = null
  description = "The ID used to reference the virtual machine. This will also be the ID of the final template. If not given, the next free ID on the node will be used"
}

variable "sockets" {
  default     = 1
  description = "How many CPU sockets to give the virtual machine"
}

variable "cores" {
  default     = 1
  description = "How many CPU cores to give the virtual machine"
}

variable "cpu_type" {
  default     = "kvm64"
  description = "The CPU type to emulate. See the Proxmox API documentation for the complete list of accepted values"
}

variable "memory" {
  default     = 512
  description = "How much memory, in megabytes, to give the virtual machine"
}

variable "os" {
  default     = "l26"
  description = "The operating system"
}

variable "onboot" {
  default     = false
  description = "Specifies whether a VM will be started during system bootup"
}

variable "disable_kvm" {
  default     = false
  description = "Disables KVM hardware virtualization"
}

variable "qemu_agent" {
  default     = true
  description = "Enables QEMU Agent option for this VM"
}

variable "cloud_init" {
  default     = false
  description = "If true, add a Cloud-Init CDROM drive after the virtual machine has been converted to a template"
}

variable "cloud_init_storage_pool" {
  default     = "local-lvm"
  description = "Name of the Proxmox storage pool to store the Cloud-Init CDROM on. If not given, the storage pool of the boot device will be used"
}

variable "network_adapters" {
  default = [
    {
      bridge = "vmbr0"
      model  = "virtio"
    }
  ]
  description = "Network adapters attached to the virtual machine"
}

variable "scsi_controller" {
  default     = "virtio-scsi-pci"
  description = "The SCSI controller model to emulate"
}

variable "disks" {
  default = [
    {
      type              = "scsi"
      disk_size         = "8G"
      format            = "raw"
      storage_pool      = "local-lvm"
      storage_pool_type = "lvm"
    }
  ]
  description = "Disks attached to the virtual machine"
}

variable "template_name" {
  description = "Name of the template"
}

variable "template_description" {
  default     = ""
  description = "Description of the template, visible in the Proxmox interface"
}

variable "insecure_skip_tls_verify" {
  default     = false
  description = "Skip validating the certificate"
}

variable "http_directory" {
  default     = ""
  description = "Path to a directory to serve using an HTTP server"
}

variable "boot_wait" {
  default     = "30s"
  description = "The time which Packer waits before sending commands"
}

variable "boot_command" {
  default     = []
  description = "List of the keys to type when the virtual machine is first booted in order to start the OS installer"
}

variable "script" {
  default     = ""
  description = "The path to a script to upload and execute in the machine"
}
