#!/usr/bin/env zsh
source functions

# SETUP ------------------------------------------------------------------------
if ! type urf_check_sanity &> /dev/null; then
    echo "urfilez-lib/functions not loaded."; exit 1
fi;
if ! urf_check_sanity; then; exit 1; fi

usage_msg() {
    echo "Usage:"
    echo "\trun - PULL Remote Repos & Run Setup (default)"
    #echo "\tpull - PULL Remote Repos"
    #echo "\tpush - PUSH Local Repos"
    echo "\thostname [get/set] - get/set your hostname"
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
    (Linux-x86*)
	echo "  Login: to Google Chrome to sync extensions"
	echo "  Locale: set English (US), Keyboard: set English (US) and Polish"
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
