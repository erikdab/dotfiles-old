#!/usr/bin/env zsh

if ! isinstalled_cmd "onedrive"; then
    PKGS=$PKGS" libcurl4-openssl-dev git libsqlite3-dev"
    SNAPS+=("dmd --classic" "dub --classic")
    installall

    cd ~/source/repos
    git clone https://github.com/skilion/onedrive.git
    cd onedrive
    make
    sudo make install
    echo "Configure onedrive connection by running command: 'onedrive' and modifying onedrive config at ~/.config/onedrive/config"

    mkdir -p ~/.config/onedrive
    cp ~/source/repos/onedrive/config ~/.config/onedrive/config

    sudo systemctl --user enable onedrive
    # sudo systemctl --user start onedrive
fi
