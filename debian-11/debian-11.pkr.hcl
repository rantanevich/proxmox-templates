packer {
  required_plugins {
    proxmox = {
      source  = "github.com/hashicorp/proxmox"
      version = "~> 1.0"
    }
  }
}

source "proxmox" "debian_11" {
  proxmox_url = var.proxmox_api
  username    = format("%s!%s", var.proxmox_username, var.proxmox_token_id)
  token       = var.proxmox_token_secret
  node        = var.proxmox_node

  memory  = 1024
  sockets = 1
  cores   = 2
  os      = "l26"

  network_adapters {
    model  = "virtio"
    bridge = "vmbr0"
  }

  qemu_agent      = true
  scsi_controller = "virtio-scsi-pci"

  disks {
    type              = "scsi"
    disk_size         = "16G"
    storage_pool      = "backup"
    storage_pool_type = "directory"
    format            = "qcow2"
  }

  cloud_init              = true
  cloud_init_storage_pool = "backup"

  ssh_username = "root"
  ssh_password = "root"
  ssh_timeout  = "10m"

  iso_file = "backup:iso/debian-11.1.0-amd64-netinst.iso"

  onboot = false

  template_name = "debian-11"
  unmount_iso   = true

  http_directory = "./http"
  boot_wait      = "10s"
  boot_command = [
    "<down><down><enter><wait>",
    "<down><down><down><down><down><down><enter><wait1m>",
    "http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter><wait10m>",
  ]
}

build {
  sources = [
    "source.proxmox.debian_11"
  ]

  provisioner "shell" {
    pause_before = "10s"
    script       = "bootstrap.sh"
  }
}
