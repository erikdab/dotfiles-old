#!/usr/bin/env zsh
source functions

# SETUP ------------------------------------------------------------------------
if ! type urf_check_sanity &> /dev/null; then
    echo "urfilez-lib/functions not loaded."; exit 1
fi;
if ! urf_check_sanity; then; exit 1; fi

# TODO: add zsh completions
usage_msg() {
    echo "Usage:"
    echo "\trun - PULL Remote Repos & Run Setup (default)"
    # echo "\tpull - PULL from Git"
    # echo "\tsync - PULL+PUSH from/to Git"
    # echo "\tstatus - Git status"
    echo "\thostname [get/set] - get/set your hostname"
    echo "\tupdate - update your system"
    echo "\tsearch - search for package"
    echo "\tinstall - install package"
    if urf_contains $WHARDWARE Linux; then
        echo "\tlayers [new/list] - new layer/list your layers"
    fi
    #echo "\trepos [get/set] - get/set your repositories"
}

case $1 in
(run)
	  urf_check_hostname
	  #urf_check_repos
	  urf_echo_whoami

	  # INSTALLATION -------------------------------------------------------------
	  source install-pkgs
	  source install-files
	  source install-prefs

	  # NOTES --------------------------------------------------------------------

	  # This could be placed in a file in the config repo
	  echo "DONE! \(^-^)/ \nKindly remember to:"
	  case $WHARDWARE in
	  (*x86*)
		    echo "  Visual Paradigm - PWR version. Activate using student email. Link: "
		    echo "    $(urf_bold https://ap.visual-paradigm.com/institute-of-informatics/license.jsp)"
		    ;|
(*Ubuntu*)
		    echo "  Select your wallpaper, sign in to Gnome Online Accounts - Google"
		    ;|
(Linux-x86*)
		    echo "  Login: to Google Chrome to sync extensions"
		    echo "  Locale: set English (US), Keyboard: set English (US) and Polish"
        echo "  Keyboard: Set caps to be ALSO Ctrl & switch languages to Win+Space"
		    ;;
	  (Darwin*)
		    echo "  Launchpad: Place Unused apps in one folder"
		    ;;
	  esac
	  ;;
(hostname)
	  case $2 in
	  (set)
		    urf_set_hostname
		    ;;
	  (get)
		    hostname
		    ;;
	  (*)
		    usage_msg
	  esac
	  ;;
(update)
	  urf_upgrade
	  ;;
(search)
	  urf_search $2
	  ;;
(install)
	  urf_install $2
	  ;;
(layers)
    if ! urf_contains $WHARDWARE Linux; then
        usage_msg
        return
    fi
    source functions-linux
	  case $2 in
	  (new)
		    new_layer $3
		    ;;
	  (list)
        print_layers
		    ;;
	  (*)
		    usage_msg
    esac
    ;;
# (repos)
#    case $2 in
#    (set)
#        urf_set_repos
#        ;;
#    (get)
#        urf_get_repos
#        ;;
#    (*)
#        usage_msg
#    esac
#    ;;
(*)
	  usage_msg
esac
# Setup my packages as layers (like in emacs):
# - Global layer - packages without any dependencies, top-level
# - seperate layers for more complicated setups, like dotnetcore, docker, virtualbox, pyenv, etc.
