# REBOOT - v.0.0.1

# Make sure user consents
while true; do
    read -p "REBOOT:SETUP will attempt to run setup scripts. Is your computer a fresh install? (Answer 'Yes' or 'No').
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
echo "Great let's continue."

# Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing Homebrew."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Homebrew is alread installed. Updating."
    brew update
fi