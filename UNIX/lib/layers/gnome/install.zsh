#!/usr/bin/env
# Perform layer installation and customization here if not yet installed
PKGS=$PKGS" chrome-gnome-shell gnome-tweaks"
installall

# GSConnect dependencies
PKGS=$PKGS" gir1.2-gdata-0.0 sshfs python3-pip libsecret-1-0 libsecret-1-dev"
installall
