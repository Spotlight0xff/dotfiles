#!/bin/sh

programs=(i3 compton bash vim offlineimap livestreamer mutt)
programs_root=(lxdm)
for t in "${programs[@]}"
do
    while true; do
        read -p "Do you wish to install $t config? " yn
        case $yn in
            [Yy]* ) stow -v $t;break;;
            [Nn]* ) break;;
            * ) echo "Please answer yes or no";;
        esac
    done
done


#for t in "${programs_root[@]}"
#do
#    while true; do
#        read -p "Do you whish to install $t config as root? " yn
#        case $yn in
#            [Yy]* ) sudo stow -t / -v $t;break;;
#            [Nn]* ) break;;
#            * ) echo "Please answer yes or no";;
#        esac
#    done
#done

read -p "Do you wish to install vim-YouCompleteMe?" yn
case $yn in
    [Yy]* ) cd vim/.vim/bundle && git clone https://github.com/Valloric/YouCompleteMe && cd YouCompleteMe && git submodule update --init --recursive && ./install.sh --omnisharp-completer --clang-completer; cd ../../../../
esac

read -p "Do you wish to install vim-MultipleCursors?" yn
case $yn in
    [Yy]* ) git clone https://github.com/terryma/vim-multiple-cursors vim/.vim/bundle/vim-multiple-cursors
esac

echo "Done :)"
