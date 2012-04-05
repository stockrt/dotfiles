#!/usr/bin/env bash

# This script installs the dotfiles in your home.


##########
## ARGS ##
##########

usage () {
    echo "
This script installs the dotfiles in your homedir.

Usage: $0 -n <name> -e <email>
    -n Your name.
    -e Your e-mail.

Example:
    $0 -n \"Rogério Carvalho Schneider\" -e stockrt@gmail.com
"
}

while getopts n:e: options
do
    case "$options" in
        n)
            name="$OPTARG"
            ;;
        e)
            email="$OPTARG"
            ;;
        h)
            usage
            exit 0
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done
shift $(($OPTIND - 1))

if [[ -z "$name" || -z "$email" ]]
then
    usage
    exit 1
fi


#############
## CONFIGS ##
#############

# Exit on command or variable expansion errors
set -e -u


##########
## MAIN ##
##########

# Files
echo
find dot -mindepth 1 -maxdepth 1 -type f |\
while read L
do
    SOURCE="$L"
    DEST=${L/dot\//.}

    # bashrc or bash_profile
    if [[ "$DEST" == ".bashrc" ]]
    then
        case "$OSTYPE" in
            darwin*)
                cp -v $SOURCE ~/.bash_profile
                ;;
            *)
                cp -v $SOURCE ~/$DEST
                ;;
        esac
    # gitconfig
    elif [[ "$DEST" == ".gitconfig" ]]
    then
        sed -e "s/@@name@@/$name/g" -e "s/@@email@@/$email/g" $SOURCE > ${SOURCE}.filtered
        cp -v ${SOURCE}.filtered ~/$DEST
        rm -f ${SOURCE}.filtered
    else
        cp -v $SOURCE ~/$DEST
    fi
done

# Dirs
echo
find dot -mindepth 1 -maxdepth 1 -type d |\
while read L
do
    SOURCE="$L"
    DEST=${L/dot\//.}
    rsync -rv $SOURCE/ ~/$DEST/
done

echo

exit 0
