#!/usr/bin/env
# Perform layer installation and customization here if not yet
# CLI Programs
PKGS=$PKGS" zsh git gawk curl xsel neovim"

PKGS=$PKGS" lm-sensors"

# Add ZRAM to create super fast swap for ML, etc. 
PKGS=$PKGS" zram-config"

# GUI Programs
PKGS=$PKGS" keepassxc gimp anki gparted zathura zathura-ps tilix conky gnome-clocks python-nautilus emacs zeal"

# Publishing
PKGS=$PKGS" texlive-latex-base texlive-latex-recommended texlive-latex-extra python-pygments pandoc"

PKGS_RM="evolution ksh"

# Snaps
SNAPS+=("pycharm-professional --classic" "intellij-idea-ultimate --classic" "communitheme" "discord")
installall


# Remove texlive docs
if [ ! -z "$(dpkg -l | awk '{print $2}' | grep '^texlive.*-doc')" ]; then
	  sudo apt-get --purge remove -y ^texlive.\*-doc$
fi

# OBS Studio
REPOS+=("ppa:obsproject/obs-studio")
PKGS=$PKGS" ffmpeg obs-studio"

# pdftk
REPOS+=("ppa:malteworld/ppa")
PKGS=$PKGS" pdftk"
