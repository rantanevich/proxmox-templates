# Proxmox templates

The repository will have Packer code to build base images from ISO files.



## Usage

1. Copy `example.auto.pkrvars.hcl` to a new file with `*.auto.pkrvars.hcl` name.

1. Adjust variables in the new file and preseed and bootstrap scripts in the desired template for yourself.

1. Download Packer plugins

```sh
packer init .
```

1. Runs build your image (e.g. `debian-11`)

```
packer build -var-file=debian-11/template.pkrvars.hcl .
```
