#!/bin/bash
set -o vi

export EDITOR=vim
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

alias ls="ls -1"
alias ll="ls -lah"
alias la="ls -aF"
alias timestamp='date "+%m/%d/%Y  %H:%M"'
alias lsip='curl -s http://checkip.dyndns.org | sed "s/[a-zA-Z/<> :]//g"'
alias vi='vim'
alias gg='git status -s'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

export PATH="/usr/local/share/npm/bin:/usr/local/mysql/bin:/usr/local/sbin:$PATH"

underscore ()
{
    let fillsize=${COLUMNS}-17
    fill=""
    while [ "$fillsize" -gt "0" ]
        do
            fill="_${fill}" # fill with underscores to work on 
            let fillsize=${fillsize}-1
        done
    printf "$fill"
}

MAGENTA="\[\033[1;35m\]"
YELLOW="\[\033[1;33m\]"
BLUE="\[\033[34m\]"
LIGHT_GRAY="\[\033[0;37m\]"
CYAN="\[\033[1;36m\]"
GREEN="\[\033[0;32m\]"
RESET="\[$(tput sgr0)\]"
GIT_PS1_SHOWDIRTYSTATE=true

NEXT_PS="\n\[\e[47;30m\]\$(date '+%m/%d/%Y  %H:%M')\$(underscore)$RESET"
NEXT_PS="$NEXT_PS\n\u on $YELLOW\h$RESET in \w"
NEXT_PS="$NEXT_PS"'$(
    if [[ $(__git_ps1) =~ \*\)$ ]]
    # a file has been modified but not added
    then echo "'$YELLOW'"$(__git_ps1 " (%s)")
    elif [[ $(__git_ps1) =~ \+\)$ ]]
    # a file has been added, but not commited
    then echo "'$MAGENTA'"$(__git_ps1 " (%s)")
    # the state is clean, changes are commited
    else echo "'$BLUE'"$(__git_ps1 " (%s)")
    fi)'

export PS1="$NEXT_PS$GREEN \n▶ $RESET"


source ~/.git-completion.bash
source ~/.git-prompt.sh

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
