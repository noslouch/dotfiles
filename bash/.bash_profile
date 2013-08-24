#!/bin/bash
export EDITOR=vim
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

alias ls="ls -1 --color=always"
alias ll="ls -aFl --color=always"
alias la="ls -aF --color=always"
alias timestamp='date "+%Y.%m.%d.%H.%M"'
alias lsip='curl -s http://checkip.dyndns.org | sed "s/[a-zA-Z/<> :]//g"'

export PATH="/usr/local/share/npm/bin:/usr/local/mysql/bin:/usr/local/sbin:$PATH"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


 # ==== Shell Prompt ==== 

 # colors
 BOLD="\[$(tput bold)\]"
 RED="\[$(tput setaf 1)\]"
 WHITE="\[$(tput setaf 7)\]"
 LBLUE="\[$(tput setaf 6)\]"
 BLUE="\[$(tput setaf 4)\]"
 RESET="\[$(tput sgr0)\]"

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

NEXT_PS="\n$BOLD$RED\u$WHITE on$LBLUE \h$WHITE in$BLUE \w$WHITE \$(current_git_branch)$BLUE"

underscore ()
{
    let fillsize=${COLUMNS}-20
    fill=""
    while [ "$fillsize" -gt "0" ]
        do
            fill="_${fill}" # fill with underscores to work on 
            let fillsize=${fillsize}-1
        done
    printf "$fill"
}

NEXT_PS="$BLUE\$(underscore)\`date "+%Y.%m.%d.%H.%M"___\`$NEXT_PS\n➤ $RESET"
export PS1=$NEXT_PS

set -o vi
