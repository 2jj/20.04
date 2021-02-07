#!/bin/bash

echo "+ adding new user"
useradd -ms /bin/bash -G sudo -p $(openssl passwd -1 $PASS) $LOGIN

set -x

echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
echo "AuthorizedKeysFile /root/.ssh/authorized_keys" >> /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
chmod o+rx /root /root/.ssh /root/.ssh/authorized_keys
service sshd restart

echo 'Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades
echo 'Unattended-Upgrade::Remove-New-Unused-Dependencies "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades-
echo 'Unattended-Upgrade::Remove-Unused-Dependencies "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades
service unattended-upgrades restart

apt -y update
apt -y full-upgrade

apt install snapd
snap install nvim --edge --classic
snap install docker --edge
snap install ripgrep --edge --classic

su - $LOGIN

set -x

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install node

mkdir $HOME/.config
git clone https://github.com/2jj/nvim.git $HOME/.config/nvim
ln -sf $HOME/.config/nvim/.bash_aliases $HOME/.bash_aliases
ln -sf $HOME/.config/nvim/.tmux.conf $HOME/.tmux.conf
ln -sf $HOME/.config/nvim/.eslintrc.yml $HOME/.eslintrc.yml
ln -sf $HOME/.config/nvim/.prettierrc.yml $HOME/.prettierrc.yml
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
nvim +PlugInstall +qall --headless
