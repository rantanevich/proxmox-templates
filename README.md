# Proxmox templates

The repository will have Packer code to build base images from ISO files.



# Usage

If you want to create an image, duplicate or go to directory with desired OS and make the following steps:

1. Customize `http/preseed.cfg`, `bootstrap.sh` and `debian-11.pkr.hcl` files to suit your needs.

2. Jump to the directory with Packer files (e.g. `debian-11/`)

3. Download Packer plugins

```sh
packer init .
```

4. Runs build your image

The `PROXMOX_USERNAME` must include the token id after an exclamation mark. For example, `user@pam!tokenid`

```sh
export PROXMOX_URL='https://example.com/api2/json'
export PROXMOX_USERNAME='root@pam!packer'
export PROXMOX_TOKEN='d5630abc-af97-4845-9439-d35d89058cc9'

packer build .
```
