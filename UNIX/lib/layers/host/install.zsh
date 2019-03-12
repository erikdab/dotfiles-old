# Snaps
SNAPS+=("pycharm-professional --classic"
        "intellij-idea-ultimate --classic"
        "webstorm --classic"
        "communitheme"
        "discord"
        "gimp")

PKGS=$PKGS" lm-sensors"

# GUI Programs
PKGS=$PKGS" keepassxc anki gparted gnome-clocks zeal"
# gimp is now installed as a flatpack

# OBS Studio
REPOS+=("ppa:obsproject/obs-studio")
PKGS=$PKGS" ffmpeg obs-studio"
