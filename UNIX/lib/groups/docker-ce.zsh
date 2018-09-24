#!/usr/bin/env zsh
# Links:
# - docker Ubuntu 18.04: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04
if ! isinstalled "docker-ce"; then
    echo $(urf_btitle "Installing group" "$group")

    sudo apt update
    # Install dependencies
    sudo apt install apt-transport-https ca-certificates curl software-properties-common
    # Add GPG ke
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    # Add repo
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

    sudo apt update
    # Check policy
    # apt-cache policy docker-ce

    # Install Docker
    sudo apt install docker-ce
fi
