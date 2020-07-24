#!/bin/bash
VERSION=("0.6")
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
    echo "lp import [CATEGORY] [ID] [Name]"
    echo -e "\tThis allows you to import new Accounts"
    echo -e "\tExample: 'lp import google 54783758933 sexyman'"
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
    curl --silent --fail --show-error $GitURL"lpscript/IDs.conf" > $BASEDIR/IDs.conf
    curl --silent --fail --show-error $GitURL"lpscript/categories.conf" > $BASEDIR/categories.conf
    echo -e "${DARK_GRAY}\tCreated Initial Files for usage in $BASEDIR${NoColor}"
    echo -e "${DARK_GRAY}\tto delete this run ${BLUE}$ lp clean${NoColor}"
    exit 0
}

## This will check if you have the correct files, and download them if you don't
filetest() {
    [[ ! -d $BASEDIR ]] && fullsetup 
    [[ ! -f $BASEDIR/names.conf ]] && curl --silent --fail --show-error $GitURL"lpscript/names.conf" > $BASEDIR/names.conf
    [[ ! -f $BASEDIR/IDs.conf ]] && curl --silent --fail --show-error $GitURL"lpscript/names.conf" > $BASEDIR/IDs.conf
    [[ ! -f $BASEDIR/categories.conf ]] && curl --silent --fail --show-error $GitURL"lpscript/names.conf" > $BASEDIR/categories.conf
    [[ ! -f /usr/bin/lpass ]] && echo "You require lastpass-cli package to run this script. Please install it" && exit 0
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

## Allows you to import Accounts to the storage files for this script
import() {
    echo $arg2 >> $category
    echo $arg3 >> $id
    echo $arg4 >> $name
    echo Success!
    exit 0
}

## This is the main function of the script where all the cool stuff happens
main() {
    ## A few definitions and tests to start with
    lineNum="$(grep -n "$arg4" $name | head -n 1 | cut -d: -f1)"
    accid=$(sed -n "$lineNum"p $id)
    [ -z $lineNum ] && echo "Name could not be located" && exit 0

    ## The heart of the program
    [[ "$arg1" == "show" && "$arg3" == "user" ]] && echo "Username:" $(lpass show $accid -x --username)
    [[ "$arg1" == "show" && "$arg3" == "pass" ]] && echo "Password:" $(lpass show $accid -x --password)
    [[ "$arg1" == "copy" && "$arg3" == "user" ]] && lpass show $accid -cx --username && echo "Added to clipboard"
    [[ "$arg1" == "copy" && "$arg3" == "pass" ]] && lpass show $accid -cx --password && echo "Added to clipboard"
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
category=($BASEDIR/categories.conf)
id=($BASEDIR/IDs.conf)
name=($BASEDIR/names.conf)
arg1=($1)
arg2=($2)
arg3=($3)
arg4=($4)


## Initial Checks when the script is ran
[ "$1" == "clean" ] && clean
[ "$1" == "help" ] && help
[ "$1" == "info" ] && info
[ -z "$4" ] && usage
[ "$1" == "import" ] && import
[[ ! "$1" =~ ^(show|copy|list)$ ]] && usage
[[ ! "$3" =~ ^(user|pass|all)$ ]] && usage
filetest

## Calling the main function for the script to start
main
