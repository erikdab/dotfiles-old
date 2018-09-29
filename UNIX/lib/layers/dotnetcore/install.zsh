#!/usr/bin/env
# Perform layer installation and customization here if not yet installed
if ! isinstalled "dotnet-sdk-2.1"; then
    # Register Microsoft key and feed
    # TODO: not cross distro
    wget -P /tmp/ -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
    sudo dpkg -i /tmp/packages-microsoft-prod.deb

    # Install dependencies
    PKGS=PKGS" apt-transport-https"
    installall

    # Install runtime and SDK
    PKGS=$PKGS" aspnetcore-runtime-2.1 dotnet-sdk-2.1"
    installall
fi
