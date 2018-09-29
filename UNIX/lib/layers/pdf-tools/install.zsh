#!/usr/bin/env zsh
# Layer install script, please define: isinstalled, preinstall and install
PKGS=$PKGS" gcc g++ make automake autoconf"
installall

PKGS=$PKGS" libpng-dev zlib1g-dev libpoppler-glib-dev libpoppler-private-dev imagemagick"
installall
