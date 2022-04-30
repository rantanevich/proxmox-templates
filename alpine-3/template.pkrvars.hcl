template_name = "alpine-3"

iso_url      = "https://dl-cdn.alpinelinux.org/alpine/v3.15/releases/x86_64/alpine-virt-3.15.4-x86_64.iso"
iso_checksum = "sha256:11cb6ceec4967e0089c44268d2cc7b4efbad74f40d962ecec558e1a8fb6f2ac9"

script         = "./alpine-3/bootstrap.sh"
http_directory = "./alpine-3/http"
boot_command = [
  "root<enter><wait>",
  "ifconfig eth0 up && udhcpc -i eth0<enter><wait5>",
  "wget http://{{ .HTTPIP }}:{{ .HTTPPort }}/answers<enter><wait>",
  "setup-alpine -f answers<enter><wait5>",
  "root<enter><wait>",
  "root<enter><wait10>",
  "y<enter><wait1m>",
  "mount /dev/sda3 /mnt<enter>",
  "swapon /dev/sda2<enter>",
  "mount -t proc none /mnt/proc<enter>",
  "mount --rbind /dev /mnt/dev<enter>",
  "mount --rbind /sys /mnt/sys<enter>",
  "chroot /mnt /bin/ash -l<enter>",
  "apk update<enter><wait10>",
  "apk add qemu-guest-agent<enter>",
  "echo GA_PATH=/dev/$(ls -1 /dev | grep vport) >> /etc/conf.d/qemu-guest-agent<enter>",
  "rc-update add qemu-guest-agent<enter>",
  "sed -i 's/^#*PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config<enter>",
  "exit<enter>",
  "reboot<enter>",
]
