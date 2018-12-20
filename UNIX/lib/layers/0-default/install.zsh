#!/usr/bin/env
# Perform layer installation and customization here if not yet
# CLI Programs
PKGS=$PKGS" zsh git gawk curl xsel neovim"

# Add ZRAM to create super fast swap for ML, etc. 
PKGS=$PKGS" zram-config"

# GUI Programs
PKGS=$PKGS" zathura zathura-ps tilix conky python-nautilus emacs firefox"

# Publishing
PKGS=$PKGS" texlive-latex-base texlive-latex-recommended texlive-latex-extra python-pygments pandoc"

PKGS_RM="evolution ksh"
installall

# Remove texlive docs
if [ ! -z "$(dpkg -l | awk '{print $2}' | grep '^texlive.*-doc')" ]; then
	  sudo apt-get --purge remove -y ^texlive.\*-doc$
fi

# pdftk
REPOS+=("ppa:malteworld/ppa")
PKGS=$PKGS" pdftk"

# flatpak
if ! isinstalled flatpak; then
    REPOS+=("ppa:alexlarsson/flatpak")
    PKGS=$KGS" flatpak"
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi
