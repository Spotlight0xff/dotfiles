#!/bin/sh

programs=(i3 compton bash vim)
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


for t in "${programs_root[@]}"
do
    while true; do
        read -p "Do you whish to install $t config as root? " yn
        case $yn in
            [Yy]* ) sudo stow -t / -v $t;break;;
            [Nn]* ) break;;
            * ) echo "Please answer yes or no";;
        esac
    done
done
