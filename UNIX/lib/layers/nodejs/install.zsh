#!/usr/bin/env
if ! isinstalled nodejs; then
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -

    PKGS=$PKGS" nodejs"

    installall

    npm install -g live-server
fi
