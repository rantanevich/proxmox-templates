# Proxmox templates

The repository will have Packer code to build base images from ISO files.



# Usage

If you want to create an image, duplicate or go to directory with desired OS and make the following steps:

1. Jump to the directory with Packer files (e.g. `debian-11/`)

2. Customize `http/preseed.cfg`, `bootstrap.sh` and clone `example.pkrvars.hcl` to suit your needs.

3. Download Packer plugins

```sh
packer init .
```

4. Runs build your image

```sh
packer build .
```
