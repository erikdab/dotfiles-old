#!/usr/bin/env zsh
# Links:
# - dotnetcore: https://www.microsoft.com/net/download/linux-package-manager/ubuntu18-04/runtime-2.1.0
# - dotnetsdk: https://www.microsoft.com/net/learn/dotnet/hello-world-tutorial
if ! isinstalled "dotnet-sdk-2.1"; then
    echo $(urf_btitle "Installing group" "$group")

    # Register Microsoft key and feed
    wget -P /tmp/ -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
    sudo dpkg -i /tmp/packages-microsoft-prod.deb

    # Install runtime and SDK and dependencies
    sudo apt-get install -y apt-transport-https
    sudo apt-get update
    sudo apt-get install -y aspnetcore-runtime-2.1
    sudo apt-get install -y dotnet-sdk-2.1
fi
