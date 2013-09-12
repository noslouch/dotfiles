#!/bin/bash
export EDITOR=vim
export TERM=xterm-256color
export CLICOLOR=1
#export LSCOLORS=GxFxCxDxBxegedabagaced

alias ls="ls -1"
alias ll='ls -lah'
alias la="ls -aF"
alias timestamp='date "+%m/%d/%Y  %H:%M"'
alias lsip='curl -s http://checkip.dyndns.org | sed "s/[a-zA-Z/<> :]//g"'
alias vi='vim'

export PATH="/usr/local/share/npm/bin:/usr/local/mysql/bin:/usr/local/sbin:$PATH"

 # ==== Shell Prompt ==== 

 # colors
# BOLD="\[$(tput bold)\]"
# RED="\[$(tput setaf 1)\]"
# WHITE="\[$(tput setaf 7)\]"
# LBLUE="\[$(tput setaf 6)\]"
# BLUE="\[$(tput setaf 4)\]"

function parse_git_branch {
    ref=$(git-symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}")"
}

current_git_branch () 
{ 
    local b="$(git symbolic-ref HEAD 2>/dev/null)";
    if [ -n "$b" ]; then
        printf "on git branch$(tput setaf 4) %s" "${b##refs/heads/}";
    fi
}

#NEXT_PS="\n$BOLD$RED\u$WHITE on$LBLUE \h$WHITE in$BLUE \w$WHITE \$(current_git_branch)$BLUE"

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

#NEXT_PS="$BLUE\$(underscore)\`date "+%Y.%m.%d.%H.%M"___\`$NEXT_PS\n➤ $RESET"
#export PS1=$NEXT_PS

set -o vi

source ~/.git-completion.bash
source ~/.git-prompt.sh

MAGENTA="\[\033[1;35m\]"
YELLOW="\[\033[1;33m\]"
BLUE="\[\033[34m\]"
LIGHT_GRAY="\[\033[0;37m\]"
CYAN="\[\033[1;36m\]"
GREEN="\[\033[0;32m\]"
RESET="\[$(tput sgr0)\]"
GIT_PS1_SHOWDIRTYSTATE=true
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

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

alias gg='git status -s'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

