# Snaps
SNAPS+=("pycharm-professional --classic" "intellij-idea-ultimate --classic" "communitheme" "discord")

PKGS=$PKGS" lm-sensors"

# GUI Programs
PKGS=$PKGS" keepassxc gimp anki gparted zathura zathura-ps tilix conky gnome-clocks python-nautilus emacs zeal"

# OBS Studio
REPOS+=("ppa:obsproject/obs-studio")
PKGS=$PKGS" ffmpeg obs-studio"
