#!/bin/bash
VERSION=("0.2")
##########################
## Preloading Functions ##
##########################

## Just returns back the correct usage then exits the script
usage() { echo -e "\t${BLUE}$ lp <copy|show|clean|help> <SECTION|list> <user|pass|all> <name>${NoColor}"; exit 0; }

## Sets up the script for initial usage
setup() {
    mkdir ~/.cache/lpscript
    touch ~/.cache/lpscript/file.txt
    echo -e "${DARK_GRAY}\tCreated Initial Files for usage in ~/.cache/lpscript${NoColor}"
    echo -e "${DARK_GRAY}\tto delete this run ${BLUE}$ lp clean${NoColor}"
}

info() {
    echo -e "${BLUE}\tVersion: ${RED}$VERSION${NoColor}"
    exit 0
}

## Cleans up the temporary files for the scipt
clean() {
    [[ ! -f ~/.cache/lpscript/file.txt ]] && echo -e "\t${DARK_GRAY}There were no files to be cleaned${NoColor}" && exit 
    rm -r ~/.cache/lpscript
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

## Initial Checks when the script is ran
[ "$1" == "clean" ] && clean
[ "$1" == "help" ] && usage
[ "$1" == "info" ] && info
[ -z "$4" ] && usage
[[ ! "$1" =~ ^(show|copy)$ ]] && usage
[[ ! "$3" =~ ^(user|pass|all)$ ]] && usage
[[ ! -f ~/.cache/lpscript/file.txt ]] && setup 

## Calling the main function for the script to start
main
