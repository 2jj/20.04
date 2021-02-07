#!/bin/bash
#  curl https://raw.githubusercontent.com/2jj/20.04/main/as-root.sh | (export LOGIN=? PASS=?; bash -)

echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
echo "AuthorizedKeysFile /root/.ssh/authorized_keys" >> /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
chmod o+rx /root /root/.ssh /root/.ssh/authorized_keys
service sshd restart

echo 'Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades
echo 'Unattended-Upgrade::Remove-New-Unused-Dependencies "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades-
echo 'Unattended-Upgrade::Remove-Unused-Dependencies "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades
service unattended-upgrades restart

useradd -ms /bin/bash -G sudo -p $(openssl passwd -1 $PASS) $LOGIN

do-release-upgrade
apt update -y
apt install snapd

snap install nvim --edge --classic
snap install docker --edge
snap install ripgrep --edge --classic

su - $LOGIN
