#!/bin/bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ]P && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install node

mkdir $HOME/.config
git clone https://github.com/2jj/nvim.git $HOME/.config/nvim
ln -sf $HOME/.config/nvim/.bash_aliases $HOME/.bash_aliases
ln -sf $HOME/.config/nvim/.tmux.conf $HOME/.tmux.conf
ln -sf $HOME/.config/nvim/.eslintrc.yml $HOME/.eslintrc.yml
ln -sf $HOME/.config/nvim/.prettierrc.yml $HOME/.prettierrc.yml
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
nvim +PlugInstall +qall --headless
