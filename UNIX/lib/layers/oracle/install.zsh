#!/usr/bin/env zsh
# Perform layer installation and customization here if not yet installed
if ! isinstalled "virtualbox-6.0"; then
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
    # Standard "multiverse" Ubuntu repository Virtualbox
    REPOS+=("deb https://download.virtualbox.org/virtualbox/debian bionic contrib")
    PKGS=$PKGS" virtualbox-6.0"

    installall

    # Virtualized Ubuntu needs: sudo apt-get install build-essential linux-headers-$(uname -r)
    # Next add user to vboxsf:
    # sudo usermod -G vboxsf -a $(whoami)
    # https://www.ostechnix.com/check-linux-system-physical-virtual-machine/
fi

# Java
REPOS+=("ppa:linuxuprising/java" "ppa:webupd8team/java")
PKGS=$PKGS" oracle-java10-installer oracle-java8-installer"
