# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export EDITOR="vim"
DEFAULT_USER='noSlouch'
alias lsip='curl -s http://checkip.dyndns.org | sed "s/[a-zA-Z/<> :]//g"'
alias vi='vim'
alias gg='git status -s'

alias demo='ssh publisher@publisher-demo-app-0.nypr.digital'
alias app0='ssh publisher@publisher-prod-app-0.nypr.digital'
alias app1='ssh publisher@publisher-prod-app-1.nypr.digital'
alias app2='ssh publisher@publisher-prod-app-2.nypr.digital'
alias app3='ssh publisher@publisher-prod-app-3.nypr.digital'
alias app4='ssh publisher@publisher-prod-app-4.nypr.digital'
alias app5='ssh publisher@publisher-prod-app-5.nypr.digital'
alias tunnel='ssh -f bwhitton@dev.wnyc.net -L 5432:publisher-dev-rds.nypr.digital:5432 -N'

publisher() { 
  local SETTINGS
  local PORT
  while [[ $# > 1 ]]
  do
  key="$1"

  case $key in
      -s|--settings)
      SETTINGS="$2"
      shift # past argument
      ;;
      -p|--port)
      PORT="$2"
      shift # past argument
      ;;
  esac
  shift # past argument or value
  done
  if [[ -z $SETTINGS ]]; then
    SETTINGS=wnyc
  fi
  if [[ -z $PORT ]]; then
    PORT=4567
  fi
  ./manage.py runserver 0.0.0.0:${PORT} --settings=puppy.settings.${SETTINGS}_settings
}

web() {
  local PORT
  local PROXY
  local CLIENT

  for client in wnyc wqxr newsounds wnycstudios; do
    if [ -n "$1" ] && [ $1 == $client ]; then
      CLIENT=$1
      break
    fi
  done

  while [[ $# > 1 ]]
  do
    key=$1
    case $key in
      -p|--port)
      PORT=$2
      shift
      ;;
      -x|--proxy)
      PROXY=$2
      shift
      ;;
    esac
    shift
  done
  if [ -z "$PORT" ]; then
    PORT=4200
  fi
  if [ -n "$CLIENT" ]; then
    PROXY=https://$CLIENT.demo2.wnyc.net
  elif [ -z "$PROXY" ]; then
    PROXY=http://localhost:4567
  fi
  ember serve --proxy ${PROXY} --port ${PORT} --live-reload-port 45914
}

autoload -U zmv
alias mmv='noglob zmv -W'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
ZSH_THEME="bureau"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git gitfast colorize iwhois npm zsh-syntax-highlighting zsh-nvm history-substring-search)
fpath=(~/.zsh $fpath)

source $ZSH/oh-my-zsh.sh

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

# visual editing on the cli
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# reduce delay going into command mode
export KEYTIMEOUT=30

function venv_info {
  [ -n "$VIRTUAL_ENV" ] && echo "(`basename "$VIRTUAL_ENV"`) "
}

# add visual indicators for command and insert mode
function zle-line-init zle-keymap-select {
  COMMAND_PROMPT='%{$fg_bold[white]%}[C]'
  INSERT_PROMPT='%{$fg_bold[white]%}[I]'
  PROMPT="$(venv_info)${${KEYMAP/vicmd/$COMMAND_PROMPT}/(main|viins)/$INSERT_PROMPT} $_LIBERTY "
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# fix delete after switching to command mode
bindkey "^?" backward-delete-char

# use `jj` to switch into command mode
bindkey -M viins 'jj' vi-cmd-mode

# visual editing on the cli
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# User configuration

export PATH="$PATH:$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"

if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock;
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

ssh-add

export ERL_CRASH_DUMP=/tmp/erl.dump

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # this loads nvm

ssh-add

export ERL_CRASH_DUMP=/tmp
