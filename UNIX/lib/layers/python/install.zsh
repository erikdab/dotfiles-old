#!/usr/bin/env
# Perform layer installation and customization here if not yet installed
# pyenv (1)
PKGS=$PKGS" make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev"
installall

# (1) (pyenv requirements) [link](https://github.com/pyenv/pyenv/wiki/Common-build-problems)
if [ ! -d ~/.pyenv ]; then
	  echo $(urf_bold "Install: pyenv")
	  curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
fi
