#!/bin/bash

echo "### Configuring ssh..."
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
echo "AuthorizedKeysFile /root/.ssh/authorized_keys" >> /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
chmod o+rx /root /root/.ssh /root/.ssh/authorized_keys
service sshd restart

echo "### Configuring unattended upgrades..."
echo 'Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades
echo 'Unattended-Upgrade::Remove-New-Unused-Dependencies "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades-
echo 'Unattended-Upgrade::Remove-Unused-Dependencies "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades
service unattended-upgrades restart

echo "### Adding new user..."
useradd -ms /bin/bash -G sudo -p $(openssl passwd -1 $PASS) $LOGIN

echo "### Upgrading system..."
apt -y update
apt -y full-upgrade

echo "### Installing snap, nvim, docker, ripgrep..."
apt install snapd
snap install nvim --edge --classic
snap install docker --edge
snap install ripgrep --edge --classic

echo "### su'ing to user..."
su - $LOGIN
