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

🎁 Your machine is ready! 
