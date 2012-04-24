#!/usr/bin/env bash

# Copyright (C) 2012 Rogério Carvalho Schneider <stockrt@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
# dotfiles
#
# Created:  Apr 05, 2012
# Author:   Rogério Carvalho Schneider <stockrt@gmail.com>


##########
## ARGS ##
##########

usage () {
    echo "
This script installs the dotfiles in your homedir.

Usage: $0 -n <name> -e <email> -u <github user> -p <github password>
    -n Your full name.
    -e E-mail address.
    -u Github user.
    -p Github password.

Example:
    $0 -n \"Rogério Carvalho Schneider\" -e stockrt@gmail.com -u stockrt -p secret
"
}

while getopts n:e:u:p: options
do
    case "$options" in
        n)
            name="$OPTARG"
            ;;
        e)
            email="$OPTARG"
            ;;
        u)
            gituser="$OPTARG"
            ;;
        p)
            gitpass="$OPTARG"
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

if [[ -z "$name" || -z "$email" || -z "$gituser" || -z "$gitpass" ]]
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

    # gitconfig filter
    if [[ "$DEST" == ".gitconfig" ]]; then
        sed -e "s/@@name@@/$name/g"         \
            -e "s/@@email@@/$email/g"       \
            -e "s/@@gituser@@/$gituser/g"   \
            -e "s/@@gitpass@@/$gitpass/g"   \
            $SOURCE > ${SOURCE}.filtered
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
