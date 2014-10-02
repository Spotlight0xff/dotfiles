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


#if [[ $UID != 0 ]]; then
#    echo "launch $1 as root"
#    exit
#fi




function do_symlink()
{
    echo "symlinking the shit out of it!"
}

function do_copy()
{
    echo "copy the shit out of it!"
}


while true; do
    echo "Do you want to copy the files or just symlink them?"
    echo "[1] copy"
    echo "[2] symlink"

    echo -ne "\n[2] "
    read method


    case $method in
        '1')
            do_copy
            ;;
        '2')
            do_symlink
            ;;
        *)
            continue
            ;;
    esac
    echo "All operations finished"
    exit 0
done


