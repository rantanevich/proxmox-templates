#!/bin/sh
export DEBIAN_FRONTEND=noninteractive

OS_USERNAME=raman_a
GITHUB_USERNAME=rantanevich

apt-get update
apt-get upgrade -y

apt-get install -y \
	curl \
    nano \
    gnupg \
    cloud-init

# openssl passwd -6
useradd \
    --create-home \
    --groups sudo \
    --password '$6$bWR.q82l9CkKF/SY$7LWeK/O6GSplaGjRNzHjrEOkDWciWrA/7V98BhSBM7uUDvTabokJss3r7wCKSS6ol.Cu2PMLpq9A2PDn6N4cZ0' \
    --shell /bin/bash \
    ${OS_USERNAME}

mkdir -p /home/${OS_USERNAME}/.ssh
curl \
	--location \
	--output /home/${OS_USERNAME}/.ssh/authorized_keys \
	https://github.com/${GITHUB_USERNAME}.keys
chown -R ${OS_USERNAME}. /home/${OS_USERNAME}/.ssh
chmod 700 /home/${OS_USERNAME}/.ssh
chmod 600 /home/${OS_USERNAME}/.ssh/authorized_keys

cat > /etc/ssh/sshd_config <<-EOF
Port 22
Protocol 2
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key

SyslogFacility AUTH
LogLevel INFO

LoginGraceTime 1m
PermitRootLogin no
StrictModes yes
MaxAuthTries 5
MaxSessions 5

PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
IgnoreRhosts yes
HostbasedAuthentication no
ChallengeResponseAuthentication no
PermitEmptyPasswords no
PasswordAuthentication yes

PrintMotd no
TCPKeepAlive yes
ClientAliveCountMax 3
ClientAliveInterval 20
MaxStartups 10:30:100

X11Forwarding no

AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
UseDNS no
EOF

cat > /etc/nftables.conf <<EOF
table inet filter {
	chain input {
		type filter hook input priority filter; policy drop;
		ct state invalid counter drop
		ct state { established, related } accept
		iif "lo" accept
		iif != "lo" ip daddr 127.0.0.0/8 counter drop
		ip protocol icmp accept
		tcp dport 22 accept
		counter comment "dropped packets"
	}

	chain forward {
		type filter hook forward priority filter; policy drop;
		counter comment "dropped packets"
	}

	chain output {
		type filter hook output priority filter; policy accept;
	}
}
EOF

cat > /etc/cloud/cloud.cfg <<EOF
users:
- default

disable_root: true
preserve_hostname: false
apt_preserve_sources_list: true

cloud_init_modules:
- migrator
- seed_random
- bootcmd
- write-files
- growpart
- resizefs
- disk_setup
- mounts
- set_hostname
- update_hostname
- update_etc_hosts
- ca-certs
- rsyslog
- users-groups
- ssh

cloud_config_modules:
- ssh-import-id
- locale
- set-passwords
- grub-dpkg
- apt-pipelining
- apt-configure
- ntp
- timezone
- runcmd

cloud_final_modules:
- package-update-upgrade-install
- fan
- rightscale_userdata
- scripts-vendor
- scripts-per-once
- scripts-per-boot
- scripts-per-instance
- scripts-user
- ssh-authkey-fingerprints
- keys-to-console
- phone-home
- final-message
- power-state-change

system_info:
  distro: debian
EOF

systemctl restart sshd
systemctl enable --now nftables.service

truncate -s 0 /etc/machine-id

passwd --delete root
passwd --lock root
