#!/usr/bin/env bash

# This script installs the dotfiles in your home.

# files
echo
find dot -mindepth 1 -maxdepth 1 -type f |\
while read L
do
    SOURCE="$L"
    DEST=${L/dot\//.}
    cp -v $SOURCE ~/$DEST
done

# dirs
echo
find dot -mindepth 1 -maxdepth 1 -type d |\
while read L
do
    SOURCE="$L"
    DEST=${L/dot\//.}
    rsync -rv $SOURCE/ ~/$DEST/
done

## profile.d
#echo
#find profile.d -mindepth 1 -maxdepth 1 -type f |\
#while read L
#do
#    SOURCE="$L"
#    DEST="/etc/$L"
#    sudo cp -v $SOURCE $DEST
#    sudo chmod -v 755 $DEST
#done

echo
echo "#####################################################################"
echo "IF YOU ARE **NOT** \"Rogério Carvalho Schneider <stockrt@gmail.com>\"
REMEMBER TO CHANGE THE USER NAME AND E-MAIL IN ~/.gitconfig"
echo "#####################################################################"
echo
