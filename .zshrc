#zmodload zsh/zprof
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

DISABLE_MAGIC_FUNCTIONS=true

ZSH_THEME=""
plugins=(
  git
  gitfast
  evalcache
  colorize
  history-substring-search
)
fpath=(~/.zsh $fpath)

source $ZSH/oh-my-zsh.sh

_evalcache pyenv init -
_evalcache thefuck --alias

# pure prompt config
zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:path color 039
zstyle :prompt:pure:prompt:success color 034
zstyle :prompt:pure:git:dirty color 226
autoload -U promptinit; promptinit
RPROMPT='20%D %*'
prompt pure

export EDITOR="vim"
DEFAULT_USER=$(whoami)

alias lsip='curl -s http://checkip.dyndns.org | sed "s/[a-zA-Z/<> :]//g"'
alias vi='vim'

autoload -U zmv
alias mmv='noglob zmv -W'

# clean diff
alias gdk="git diff -- ':(exclude)*package-lock*'"


# check completions once a day to speed up shell starts
autoload -Uz compinit
setopt extendedglob
for dump in $HOME/.zcompdump(#qN.m1); do
  compinit
  if [[ -s "$dump" && (! -s "$dump.zwc" || "$dump" -nt "$dump.zwc") ]]; then
    zcompile "$dump"
  fi
done
unsetopt extendedglob
compinit -C

bindkey -v

# Better searching in command mode
# re-enter command mode after entering query and use `?` to scroll results
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
bindkey "^[OA" history-substring-search-up
bindkey "^[OB" history-substring-search-down
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down

# fix delete after switching to command mode
bindkey "^?" backward-delete-char

# use `jj` to switch into command mode
bindkey -M viins 'jj' vi-cmd-mode

# visual editing on the cli
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# reduce delay going into command mode
export KEYTIMEOUT=30

function venv_info {
  [ -n "$VIRTUAL_ENV" ] && echo "(`basename "$VIRTUAL_ENV"`) "
}

# User configuration

export PATH="/usr/local/Cellar/sqlite/3.38.1/bin:$PATH:$HOME/bin:$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"

if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock;
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -q

export ERL_CRASH_DUMP=/tmp/erl.dump

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#zprof

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U +X bashcompinit && bashcompinit
