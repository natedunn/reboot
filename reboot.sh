#!/bin/sh

###########################
# Reboot
# Author: Nate Dunn
# URL: https://github.com/natedunn/reboot
###########################


# Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
Color_End='\033[0m'       # Text Reset

#Variables
composer -v > /dev/null 2>&1
COMPOSER_IS_INSTALLED=$?

valet -V > /dev/null 2>&1
VALET_IS_INSTALLED=$?

# Welcome
echo "\n${Blue}Welcome to Reboot.${Color_End}"

# Make sure user consents
echo "Are you ready to start? This might take a while. (Answer 'Yes' or 'No')"
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    break
else
    echo "Ok. Exiting!"
    exit
fi

#(Oh My) ZSH
echo "\n${Blue}• Oh My Zsh${Color_End}"
if [[ $SHELL != /bin/zsh ]] ; then
    echo "Oh My Zsh is not installed. Installing."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is installed and your current shell."
fi

# (Oh My) ZSH Plugins
echo "\n${Blue}• Oh My Zsh Plugins${Color_End}"
echo "• Installing Z"
cd ~
mkdir .zee
cd .zee
curl -O -J https://raw.githubusercontent.com/rupa/z/master/z.sh
cd ~

echo "• Installing zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "• Installing zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Homebrew
echo "\n${Blue}• Homebrew${Color_End}"
which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing lastest version of Homebrew."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo 'export PATH="/usr/local/bin:$PATH"' >>~/.bash_profile
else
    echo "Homebrew is already installed. Updating."
    brew update
    # brew doctor
fi

echo "\n• Homebrew Packages"
declare -a arr=(
    "php"
    "mas"
    "php@5.6"
    "php@7.0"
    "php@7.1"
)
for i in "${arr[@]}"
do
    if brew ls --versions $i &> /dev/null; then
        echo "$i is installed"
        brew ls --versions $i
    else
        echo "$i has not been installed. Installing now."
        brew install $i
    fi
done

echo "\n• Homebrew Cask"
declare -a arr=(
    "1password"
    # "nordvpn"
    # "authy"
    # "fantastical"
    # "cleanmymac"
    # "rescuetime"
    # "slack"
    # "spotify"
    # "vlc"
    # "sizeup"
    # "hyperswitch"
    # "the-clock"
    # "sip"
    # "figma"
    # "sketch"
    # "firefox"
    # "google-chrome"
    # "visual-studio-code"
    # "hyperterm"
    # "tower"
    # "transmit"
    # "virtualbox"
    # "sim-daltonism"
)
for i in "${arr[@]}"
do
    if brew cask ls --versions $i &> /dev/null; then
        echo "$i is installed"
    else
        echo "$i has not been installed. Installing now."
        brew cask install $i
    fi
done

# Node
echo "\n${Blue}• Node.js${Color_End}"
which -s node
if [[ $? != 0 ]] ; then
    echo "Installing lastest version of Node.js."
    brew install node
else
    echo "Node.js is already installed."
    node -v
fi

# NPM
echo "\n${Blue}• NPM${Color_End}"
which -s npm
if [[ $? != 0 ]] ; then
    echo "Downloading lastest version of NPM."
    cd ~/Downloads
    git clone git://github.com/isaacs/npm.git && cd npm
    git checkout v${NPM_VERSION}
    echo "Installing NPM"
    make install
    cd ~
else
    echo "NPM is already installed. Updating."
    npm -v
    # npm install -g npm@latest
fi

# Xcode & Git
echo "\n${Blue}• Git${Color_End}"
if type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
    test -d "${xpath}" && test -x "${xpath}" ; then
    echo "Git is already installed."
else
    echo "Git is not installed. Installing."
    xcode-select --install
fi
git --version

echo "\n${Blue}• Composer${Color_End}"
if [[ $COMPOSER_IS_INSTALLED -ne 0 ]]; then
    echo "Composer is not installed. Installing."
    brew install composer
else
    echo "Composer is already installed."
fi
composer --version

echo "\n${Blue}• Valet${Color_End}"
if [[ $VALET_IS_INSTALLED -ne 0 ]]; then
    echo "Valet is not installed. Installing."
    composer global require laravel/valet
else
    echo "Valet is already installed."
fi
valet --version

# Download dotfiles
echo "\n${Blue}• Downloading Custom dotfiles to ~/Downloads.${Color_End}"
cd ~/Downloads
git clone git@github.com:natedunn/dotfiles.git

echo "\n${Blue}• Reboot Complete! ${Color_End}"
exit