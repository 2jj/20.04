#!/bin/bash

# Setup user
echo "+ adding new user to sudo and docker groups"
groupadd -f docker
useradd -ms /bin/bash -G sudo,docker -p $(openssl passwd -1 $P) $L

# Log commands
set -x

# Setup ssh
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
echo "AuthorizedKeysFile /root/.ssh/authorized_keys" >> /etc/ssh/sshd_config
sed -ie 's/PermitRootLogin\syes/PermitRootLogin no/g' /etc/ssh/sshd_config
chmod o+rx /root /root/.ssh /root/.ssh/authorized_keys
service sshd restart

# Setup unattended-upgrade
echo 'Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades
echo 'Unattended-Upgrade::Remove-New-Unused-Dependencies "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades-
echo 'Unattended-Upgrade::Remove-Unused-Dependencies "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades
service unattended-upgrades restart

# Increase file watchers
echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf
sysctl -p

sysctl -p

# Setup apps
apt -y update
apt -y full-upgrade
apt -y install git
apt -y install ripgrep
apt -y install tmux
apt -y install python3-venv
apt -y install fd-find

apt -y install snapd
snap install nvim --edge --classic

# Switch to non-root user
su - $L

# node
echo "+ adding nvm and latest node..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install node

# Log commands
set -x

# npm-based apps
npm install -g nodemon

# Config fd
mkdir -p $HOME/.local/bin
ln -s $(which fdfind) ~/.local/bin/fd

# Config apps
mkdir $HOME/.config
git clone https://github.com/2jj/nvim.git $HOME/.config/nvim
ln -sf $HOME/.config/nvim/.bash_aliases $HOME/.bash_aliases
ln -sf $HOME/.config/nvim/.tmux.conf $HOME/.tmux.conf
ln -sf $HOME/.config/nvim/.eslintrc.yml $HOME/.eslintrc.yml
ln -sf $HOME/.config/nvim/.prettierrc.yml $HOME/.prettierrc.yml
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "set -o vi" >> $HOME/.profile
nvim +PlugInstall +qall --headless
ranger --copy-config=all
