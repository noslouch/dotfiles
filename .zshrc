# uvx tools
. "$HOME/.local/bin/env"

# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/whittonb/.zsh/completions:"* ]]; then export FPATH="/Users/whittonb/.zsh/completions:$FPATH"; fi

#zmodload zsh/zprof
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

ZSH_THEME=""
plugins=(
  git
  gitfast
  colorize
  history-substring-search
)
fpath=(~/.zsh $fpath)
fpath+=("$(brew --prefix)/share/zsh/site-functions")

source $ZSH/oh-my-zsh.sh

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

## android testing stuff
#export ANDROID_HOME=/Users/whittonb/Library/Android/sdk
#export JAVA_HOME=$(/usr/libexec/java_home)
# export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"

# put postgres 18 in path
export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"


if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock;
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -q

# erlang crash dump location
# export ERL_CRASH_DUMP=/tmp/erl.dump

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# profile zsh startup time
# zprof

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U +X bashcompinit && bashcompinit

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/google-cloud-sdk/completion.zsh.inc'; fi

# bun completions
[ -s "/Users/whittonb/.bun/_bun" ] && source "/Users/whittonb/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# . "/Users/whittonb/.deno/env"
# . "$HOME/.cargo/env"

# Allow running curl against local domains using consumer certs
alias curlLocal='curl --cacert "/Users/whittonb/.consumer-certs/rootCA.pem"'

eval "$(saml2aws --completion-script-zsh)"

complete -C aws_completer aws
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/whittonb/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# zscaler certs
# source /opt/newscorp/zscaler/zscaler.inc

alias claude="/Users/whittonb/.claude/local/claude"
