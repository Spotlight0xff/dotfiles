#!/usr/bin/bash

# i3 config
# lxdm config
# iptables config?
# compton config
# conky + lua
# .vimrc
# vim:
## pathogen
## vim-powerline (?)
## vim-dispatch
## Omnisharp
## syntastic
## YouCompleteMe
# .bashrc


if [[ $UID != 0 ]]; then
    echo "launch $1 as root"
    exit
fi
