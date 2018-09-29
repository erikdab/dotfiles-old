#!/usr/bin/env
# Perform layer installation and customization here if not yet installed
if ! isinstalled "virtualbox"; then
    # Standard "multiverse" Ubuntu repository Virtualbox
    PKGS=$PKGS" virtualbox"

    # Java
    REPOS+=("ppa:linuxuprising/java")
    PKGS=$PKGS" oracle-java10-installer"
    installall

    # Virtualized Ubuntu needs: sudo apt-get install build-essential linux-headers-$(uname -r)
    # Next add user to vboxsf:
    # sudo usermod -G vboxsf -a $(whoami)
    # https://www.ostechnix.com/check-linux-system-physical-virtual-machine/
fi
