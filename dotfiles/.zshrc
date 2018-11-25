# Path to your oh-my-zsh installation.
export ZSH="/Users/natedunn/.oh-my-zsh"

SPACESHIP_GIT_SYMBOL=""
ZSH_THEME="spaceship"

plugins=(
  git
  npm
  osx
  brew
  vscode
  yarn
  websearch
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
export _Z_DATA="$HOME/.zee/.z-data"
. ~/.zee/z.sh

function t() {
  tree -I '.git|node_modules|bower_components|.DS_Store' --dirsfirst --filelimit 20 -L ${1:-3} -aC $2
}

alias rm=trash
alias start='npm run start'

SPACESHIP_PROMPT_ORDER=(
  dir
  git
  php
  line_sep
  char
)

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH=$PATH:~/.composer/vendor/bin