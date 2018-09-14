#!/bin/bash

# Works in bash, not in zsh, ZSH variation in helper
function yNprompt {
    # $1: Message
    echo -n "$1 "
    read -n 1 prompt_ans
    # Fix for newline entering
    if [ ! -z $prompt_ans ]; then
	echo ""
	prompt_ans=$(python -c "print('$prompt_ans').lower()" )
    fi
    local default_ans="y"
    if [[ "$1" = *"(y/N)"* ]]; then
	default_ans="n"
    fi
    if ([ $default_ans = "y" ] && [ -z $prompt_ansl ]) || ([ $prompt_ans = "y" ]) &>/dev/null ; then
	return 0
    fi
    return 1
}

# On raspi need zsh, Dropbox mount using SSHFS, rather than keeping my raspberry pi synced up?
# I won't run the setup scripts very often and if I am local, then I use no bandwidth at all

# To be run on clean system: sets up prerequisits
case $(uname) in
    (Darwin)
	if ! xcode-select -p &> /dev/null; then
	    echo "Please install 'Command Line Tools for Xcode' first!"
	    echo "Install using DMG from http://developer.apple.com/download/more/"
	    
	    if ! yNprompt "Do you want to download and install automatically? (y/N)"; then
		exit 0
	    fi
	fi
	
	if ! type brew &>/dev/null; then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
	if type brew &>/dev/null; then
		brew install zsh
		brew cask install dropbox
		open -a Dropbox.app
		echo "Recommended: Copy Home-brew cache from previous install."
		open /Users/erik/Library/Caches/Homebrew
	else
		echo "Installation canceled! Complete installation before proceeding..."
		exit 1
	fi
      ;;
    (Linux)
	sudo apt-get install nautilus-dropbox zsh
      ;;
esac

echo "Sign in to Dropbox, bro. :)"
echo "Next, select folders to sync."
echo "Finally, copy Dropbox backup to ~/Dropbox and enjoy! \\(^_^)\\"

