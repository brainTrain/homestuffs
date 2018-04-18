alias ll="ls -la"
set -o vi
bind -m vi-command L:end-of-line
bind -m vi-command H:vi-first-print

export EDITOR=vi

#aliases
alias rh="echo 'sourcing bash profile'; source ~/.bashrc"

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function proml {
    local        BLUE="\[\033[0;34m\]"
    local         RED="\[\033[0;31m\]"
    local   LIGHT_RED="\[\033[1;31m\]"
    local       GREEN="\[\033[0;32m\]"
    local LIGHT_GREEN="\[\033[1;32m\]"
    local       WHITE="\[\033[1;37m\]"
    local  LIGHT_GRAY="\[\033[0;37m\]"
    case $TERM in
          xterm*)
          TITLEBAR='\[\033]0;\u@\h:\w\007\]'
          ;;
          *)
          TITLEBAR=""
          ;;
        esac

PS1="${TITLEBAR}\
$BLUE[$RED\$(date +%H:%M)$BLUE]\
$BLUE[$RED\u@\h:\w$GREEN\$(parse_git_branch)$BLUE]\
$GREEN\$ "
PS2='> '
PS4='+ '
}
proml

publish () {
  git fetch
  if [[ $(git rev-parse HEAD) != $(git rev-parse @{u}) ]]; then
    return 1
  fi  
  npm version $1 && git push origin --tags
}

getpr () {
  git fetch origin pull/$1/head && git checkout -b pr$1 FETCH_HEAD
}
