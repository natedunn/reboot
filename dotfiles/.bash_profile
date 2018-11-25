#source ~/.profile

PS1="\[$(tput setaf 3)\]→\[$(tput sgr0)\] "

export PATH=/usr/local/bin:~/.composer/vendor/bin:$PATH

# Alias'
alias start='npm run start'