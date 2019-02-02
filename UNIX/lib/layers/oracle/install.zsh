#!/usr/bin/env
# Perform layer installation and customization here if not yet installed
if ! isinstalled "virtualbox"; then
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
    # Standard "multiverse" Ubuntu repository Virtualbox
    REPOS+=("deb https://download.virtualbox.org/virtualbox/debian bionic contrib")
    PKGS=$PKGS" virtualbox-6.0"

    # Java
    REPOS+=("ppa:linuxuprising/java")
    PKGS=$PKGS" oracle-java10-installer"
    installall

    # Virtualized Ubuntu needs: sudo apt-get install build-essential linux-headers-$(uname -r)
    # Next add user to vboxsf:
    # sudo usermod -G vboxsf -a $(whoami)
    # https://www.ostechnix.com/check-linux-system-physical-virtual-machine/
fi
