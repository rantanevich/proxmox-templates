source "proxmox" "base_image" {
  proxmox_url = var.proxmox_api
  username    = var.proxmox_username
  token       = var.proxmox_token

  insecure_skip_tls_verify = var.insecure_skip_tls_verify

  node  = var.proxmox_node
  vm_id = var.vm_id

  iso_url          = var.iso_url
  iso_storage_pool = var.iso_storage_pool
  iso_checksum     = var.iso_checksum

  sockets  = var.sockets
  cores    = var.cores
  memory   = var.memory
  cpu_type = var.cpu_type

  os          = var.os
  onboot      = var.onboot
  disable_kvm = var.disable_kvm
  qemu_agent  = var.qemu_agent

  cloud_init              = var.cloud_init
  cloud_init_storage_pool = var.cloud_init_storage_pool

  dynamic "network_adapters" {
    for_each = { for idx, val in var.network_adapters : idx => val }
    iterator = item

    content {
      bridge        = item.value.bridge
      model         = try(item.value.model, "virtio")
      mac_address   = try(item.value.mac_address, null)
      vlan_tag      = try(item.value.vlan_tag, null)
      firewall      = try(item.value.firewall, false)
      packet_queues = try(item.value.packet_queues, null)
    }
  }

  scsi_controller = var.scsi_controller

  dynamic "disks" {
    for_each = { for idx, val in var.disks : idx => val }
    iterator = item

    content {
      type              = try(item.value.type, "scsi")
      disk_size         = item.value.disk_size
      storage_pool      = item.value.storage_pool
      storage_pool_type = item.value.storage_pool_type
      format            = try(item.value.format, "raw")
      cache_mode        = try(item.value.cache_mode, "none")
      io_thread         = try(item.value.io_thread, false)
    }
  }

  ssh_username = "root"
  ssh_password = "root"
  ssh_timeout  = "10m"

  template_name        = var.template_name
  template_description = var.template_description
  unmount_iso          = true

  http_directory = var.http_directory
  boot_wait      = var.boot_wait
  boot_command   = var.boot_command
}
