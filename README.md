# Proxmox templates

The repository will have Packer code to build base images from ISO files.



# Usage

If you want to create an image, duplicate or go to directory with desired OS and make the following steps:

1. Customize `http/preseed.cfg`, `bootstrap.sh` and `debian-11.pkr.hcl` files to suit your needs.

2. Download Packer plugins

```sh
packer init .
```

3. Runs build your image

```sh
packer build \
    -var "proxmox_api=https://example.com/api2/json" \
    -var "proxmox_node=pve" \
    -var "proxmox_username=root@pam" \
    -var "proxmox_token_id=packer" \
    -var "proxmox_token_secret=uuid" \
    .
```

```sh
export PKR_VAR_proxmox_api=https://example.com/api2/json
export PKR_VAR_proxmox_node=pve
export PKR_VAR_proxmox_username=root@pam
export PKR_VAR_proxmox_token_id=packer
export PKR_VAR_proxmox_token_secret=uuid

packer build .
```
