proxmox_api      = "https://pve.example.com/api2/json"
proxmox_username = "root@pam!packer"
proxmox_token    = "b171c64b-ac80-4dc2-8b2a-0b539c6bd08a"
proxmox_node     = "pve"

vm_id = 1000

cores   = 4
memory  = 4096

cloud_init              = true
cloud_init_storage_pool = "local-lvm"

network_adapters = [
  {
    bridge = "vmbr0"
    model  = "virtio"
  },
]

disks = [
  {
    type              = "scsi"
    disk_size         = "8G"
    storage_pool      = "nvme"
    storage_pool_type = "lvm"
    format            = "raw"
  },
]
