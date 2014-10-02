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

# declare the files to be copies and their destinations

declare -A files=( ["bash/bashrc"]="~/.bashrc" ["compton/compton.conf"]="~/.compton.conf" ["conky/clock_rings.lua"]="~/.conky/clock_rings.lua" ["conky/conky_lua.conf"]="~/.conky/conky_lua.conf" ["vim/vimrc"]="~/.vimrc" ["i3/config"]="~/.i3/config")
declare -A files_root=( ["lxdm/lxdm.conf"]="/etc/lxdm/lxdm.conf" )

function do_symlink()
{
    for file in "${!files[@]}"; do
        dest="${files["$file"]}"
        replace="$HOME"
        result="${dest//\~/$replace}"
        dir="${result%/*}"
        echo "ln -s $PWD/$file $result"
        mkdir -p "$dir"
        ln -s "$PWD/$file" "$result"

        #echo "$file - ${files["$file"]}"
    done 
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


