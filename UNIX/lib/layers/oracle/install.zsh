#!/usr/bin/env zsh
# Perform layer installation and customization here if not yet installed
if ! isinstalled "virtualbox"; then
    # Standard "multiverse" Ubuntu repository Virtualbox
    PKGS=$PKGS" virtualbox"

    installall

    # Virtualized Ubuntu needs: sudo apt-get install build-essential linux-headers-$(uname -r)
    # Next add user to vboxsf:
    # sudo usermod -G vboxsf -a $(whoami)
    # https://www.ostechnix.com/check-linux-system-physical-virtual-machine/
fi

# Java
REPOS+=("ppa:linuxuprising/java" "ppa:webupd8team/java")
PKGS=$PKGS" oracle-java10-installer oracle-java8-installer"
