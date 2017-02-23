# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export EDITOR="vim"
DEFAULT_USER='noSlouch'
alias lsip='curl -s http://checkip.dyndns.org | sed "s/[a-zA-Z/<> :]//g"'
alias vi='vim'
alias gg='git status -s'

alias demo='ssh wnyc@demo-www2.wnyc.net'
alias misc='ssh wnyc@prod-www-misc1.wnyc.net'
alias app1='ssh wnyc@prod-www-app1.wnyc.net'
alias app2='ssh wnyc@prod-www-app2.wnyc.net'
alias app3='ssh wnyc@prod-www-app3.wnyc.net'
alias app4='ssh wnyc@prod-www-app4.wnyc.net'
alias app5='ssh wnyc@prod-www-app5.wnyc.net'
alias app6='ssh wnyc@prod-www-app6.wnyc.net'
alias app7='ssh wnyc@prod-www-app7.wnyc.net'
alias media='ssh wnyc@prod-media.wnyc.net'
alias internal='ssh wnyc@prod-www-internal-app1.wnyc.net'
alias tunnel='ssh -f bwhitton@dev.wnyc.net -L 5432:localhost:5432 -N'

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
  while [[ $# > 1 ]]
  do
    key="$1"
    case $key in
      -p|--port)
      PORT="$2"
      shift
      ;;
      -x|--proxy)
      PROXY="$2"
      shift
      ;;
    esac
    shift
  done
  if [[ -z $PORT ]]; then
    PORT=4200
  fi
  if [[ -z $PROXY ]]; then
    PROXY=http://localhost:4567
  fi
  ember serve --proxy ${PROXY} --port ${PORT}
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
plugins=(git gitfast colorize iwhois npm bower vi-mode zsh-syntax-highlighting history-substring-search zsh-nvm)
fpath=(~/.zsh $fpath)

source $ZSH/oh-my-zsh.sh

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'l' history-substring-search-down
# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down

# User configuration

export PATH="$PATH:$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"

# virtualenwrapper
export WORKON_HOME=/usr/local/virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock;
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

