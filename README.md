### Ubuntu 20.04 MVM

1. Copy following curl incl. the prefixed space
```
 curl https://raw.githubusercontent.com/2jj/20.04/main/run.sh | (export L=X P=X; bash -)
```
2. Paste it to Bash as root
3. Replace both `X` with a non-root login name and its sudo password, press Enter
4. Login as the non-root user, either via `su` or exit and `ssh ...`
5. Run `tmux`, press `Alt-,`, then `I` to fetch all tmux plugins
6. Run `nvim` and wait until coc.vim fetches all its plugins

Install `docker` and `docker-machine` with dedicated script or manually, since installing them via snap doesn't work (docker-machine does not find machines):
https://docs.docker.com/engine/install/ubuntu/
https://docs.docker.com/machine/install-machine/

FYI, Installing node via snap doesn't work either (coc.vim doesn't find node then)

🎁 Your machine is ready! 
