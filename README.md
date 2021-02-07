### Ubuntu 20.04 MVM

1. Copy following curl incl. the prefixed space
2. Paste it to Bash as root
3. Replace both `X` with a non-root login name and its sudo password, press Enter
```
 curl https://raw.githubusercontent.com/2jj/20.04/main/run.sh | (export L=X P=X; bash -)
```
