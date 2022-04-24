#!/bin/sh
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get upgrade -y

apt-get install -y \
	curl \
    nano \
    gnupg \
    cloud-init

truncate -s 0 /etc/machine-id
