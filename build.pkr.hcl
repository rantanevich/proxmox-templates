build {
  sources = [
    "source.proxmox.base_image"
  ]

  provisioner "shell" {
    pause_before = "10s"
    script       = var.script
  }
}
