#!/usr/bin/env zsh
# Links:
# - docker Ubuntu 18.04: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04
# Each group can have some management features, like "move drive", etc.
docker_running() {
    echo "$(ps aux | grep -i docker | grep -v grep)"
}
if ! isinstalled "docker-ce"; then
    local group_title="Installing $group"
    echo $(urf_bold $group_title)

    sudo apt update
    # Install dependencies
    sudo apt install apt-transport-https ca-certificates curl software-properties-common
    # Add GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    # Add repo
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

    sudo apt update
    # Check policy
    # apt-cache policy docker-ce

    # Install Docker
    sudo apt install docker-ce

    if urf_yNprompt "Install docker to a non-standard location? (y/N)"; then
        echo -n "New docker install location: "
        read docker_location
        sudo service docker stop

        if [ -z "$(docker_running)" ]; then
            sudo tar -zcC /var/lib docker > /tmp/var_lib_docker-backup-$(date +%s).tar.gz

            urf_sudosafemv /var/lib/docker $docker_location
            sudo ln -s $docker_location /var/lib/docker

            sudo service docker start

            if [ -z "$(docker_running)" ]; then
                echo "ho"
                echo $(urf_btitle $group_title "Could not start docker process:\n$(docker_running)")
            fi
        else
            echo "ha"
            echo $(urf_btitle $group_title "Could not stop docker process:\n$(docker_running)")
        fi
    fi
fi
