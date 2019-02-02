#!/usr/bin/env
if ! isinstalled nodejs; then
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -

    PKGS=$PKGS" nodejs"

    installall

    npm install -g js-beautify
    npm install -g @angular/cli
    npm install -g @nestjs/cli
    npm install -g tern
    npm install -g eslint
fi
