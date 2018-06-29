#!/bin/sh
############
# Reboot
# Author: Nate Dunn
# URL: https://github.com/natedunn/reboot
############

# Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
Color_End='\033[0m'       # Text Reset

# Welcome
echo "${Green}Welcome to Reboot.${Color_End}"

# Make sure user consents
while true; do
    read -p "Are you ready to start? This might take a while. (Answer 'Yes' or 'No').
    > " yn
    echo
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer 'Yes' or 'No'.";;
    esac
done

# Start fresh
clear
echo "Great! Let's continue."

# Homebrew
echo "${Green}→ Homebrew${Color_End}"
which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing Homebrew."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Homebrew is already installed. Updating."
    brew update
fi