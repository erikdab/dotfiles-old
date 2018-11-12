# Snaps
SNAPS+=("pycharm-professional --classic" "intellij-idea-ultimate --classic" "communitheme" "discord")

PKGS=$PKGS" lm-sensors"

# GUI Programs
PKGS=$PKGS" keepassxc gimp anki gparted gnome-clocks zeal"

# OBS Studio
REPOS+=("ppa:obsproject/obs-studio")
PKGS=$PKGS" ffmpeg obs-studio"
