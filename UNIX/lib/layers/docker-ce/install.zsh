#!/usr/bin/env zsh
# Layer install script, please define: isinstalled, preinstall and install
docker_running() {
    echo "$(ps aux | grep -i docker | grep -v grep)"
}

# Check if layer is installed here: return 0 if true, 1 if false
if ! isinstalled "docker-ce"; then
    PKGS=$PKGS" apt-transport-https ca-certificates curl software properties-common"
    installall

    # Add GPG key (Make this cross distro compatible)
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # Add repo and pkg
    REPOS+=("deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable")
    PKGS=$PKGS" docker-ce"
    installall

    # Link: https://forums.docker.com/t/how-do-i-change-the-docker-image-installation-directory/1169
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
