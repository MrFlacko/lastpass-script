#!/bin/bash
VERSION=("0.4")
##########################
## Preloading Functions ##
##########################


help() { 
    echo -e "\nlp clean"
    echo -e "\tRemoves the temporary files required to run this program"
    echo "lp help"
    echo -e "\tDisplays this menu"
    echo "lp list"
    echo -e "\tShows a list of the names you can use that are set in the names.txt file"
    echo "lp <show|copy> [SECTION] [user|pass|all] [name]"
    echo -e "\tThe main command to run the script."
    echo -e "\tExample: 'lp show google pass randomaccountname' This will display the password for"
    echo -e "\t\t account in association with 'randomaccountname'"
    exit 0
}

## Just returns back the correct usage then exits the script
usage() {
    echo -e "Incorrect Usage. Do 'lp help' for infomation"
    exit 0
}

## Sets up the script for initial usage
fullsetup() {
    mkdir $BASEDIR
    curl --silent --fail --show-error $GitURL"lpscript/names.conf" > $BASEDIR/names.conf
    echo -e "${DARK_GRAY}\tCreated Initial Files for usage in $BASEDIR${NoColor}"
    echo -e "${DARK_GRAY}\tto delete this run ${BLUE}$ lp clean${NoColor}"
    exit 0
}

## This will check if you have the correct files, and download them if you don't
filetest() {
    [[ ! -d $BASEDIR ]] && fullsetup 
    [[ ! -f $BASEDIR/names.txt ]] && curl --silent --fail --show-error $GitURL"lpscript/names.conf" > $BASEDIR/names.txt
}

info() {
    echo -e "${BLUE}\tVersion: ${RED}$VERSION${NoColor}"
    exit 0
}

## Cleans up the temporary files for the scipt
clean() {
    [[ ! -d $BASEDIR ]] && echo -e "\t${DARK_GRAY}There were no files to be cleaned${NoColor}" && exit 0
    rm -r $BASEDIR
    echo -e "${DARK_GRAY}\tCleaned up temporary files${NoColor}"
    exit 0
}

## This is the main function of the script where all the cool stuff happens
main() {
    echo 'main function'
}


#######################
## Execution Section ##
#######################

## Just some cool colours to use
LIGHT_RED='\033[1;31m'
RED='\033[0;31m'
BLUE='\033[1;34m'
DARK_GRAY='\033[0;37m'
LIGHT_GREEN='\033[1;32m'
NoColor='\033[0m'

## A few shortcut variables
BASEDIR=("$HOME/.config/lpscript")
GitURL=('https://raw.githubusercontent.com/MrFlacko/lastpass-script/master/')

## Initial Checks when the script is ran
[ "$1" == "clean" ] && clean
[ "$1" == "help" ] && help
[ "$1" == "info" ] && info
[ -z "$4" ] && usage
[[ ! "$1" =~ ^(show|copy|list)$ ]] && usage
[[ ! "$3" =~ ^(user|pass|all)$ ]] && usage
filetest

## Calling the main function for the script to start
main
