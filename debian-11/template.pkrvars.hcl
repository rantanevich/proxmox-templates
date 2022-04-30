template_name = "debian-11"

iso_url      = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso"
iso_checksum = "sha256:7892981e1da216e79fb3a1536ce5ebab157afdd20048fe458f2ae34fbc26c19b"

script         = "./debian-11/bootstrap.sh"
http_directory = "./debian-11/http"
boot_command = [
  "<down><down><enter><wait>",
  "<down><down><down><down><down><down><enter><wait1m>",
  "http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter><wait10m>",
]
