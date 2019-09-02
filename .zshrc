#!/bin/bash
# private stuff that doesn't get pushed to github
source "$HOME/.private"

# zmodload zsh/zprof
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
RPROMPT='%D{%r}'

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export GPG_TTY=$(tty)

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# use hyphen-insensitive completion. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# export MANPATH="/usr/local/man:$MANPATH"
export ANDROID_HOME="~/Library/Android/sdk"
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export GO111MODULE=on
source $ZSH/oh-my-zsh.sh

# increase the number of files a terminal session can have open
ulimit -n 2560

export EDITOR='nvim'
export GIT_EDITOR='nvim'
export DEFAULT_USER="$(whoami)"
export FZF_DEFAULT_COMMAND='ag -l -g ""'
# export LESS='-FXr'

alias ws=workspace
alias cls='clear;ls'
alias clsa='clear;ls -a'
alias lsa='ls -lah'
alias vimc='nvim ~/.vimrc'
alias zshc='nvim ~/.zshrc'
alias killdocker='docker kill $(docker ps -q)'
alias t='tree -I node_modules -L'
alias ta='tmux a #'

# Evals
# eval "$(ssh-agent -s)"
# eval $(thefuck --alias)

alias g='git'
alias zshup='source ~/.zshrc'
alias s='subl'
alias vo='nvim $(fzf --height 30% --reverse -i)'
alias v='nvim'

vc() {
  nvim $(ag --nobreak --noheading . | fzf --reverse | awk -F ':' '{print $1" +"$2}')
}

dns() {
    curl -sI $1 | grep -E '(301|302|Server|Location|X-Cache|HTTP)'
}

findfile() {
  ag -i -g "$1"
}

confirm() {
    # call with a prompt string or use a default
    read "response?Are you sure? [y/N]"
    if [[ "$response" =~ ^[Yy]$ ]]
    then
      return 0
    fi
    return 1
}

# eval history
h() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | gsed -r 's/ *[0-9]*\*? *//' | gsed -r 's/\\/\\\\/g')
}

# print (edit) history before running
hh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | gsed -r 's/ *[0-9]*\*? *//' | gsed -r 's/\\/\\\\/g')
}

function randomsay() {
  cow=(`cowsay -l | tail -n +2 | tr  " "  "\n" | sort -R | head -n 1`)
  cowsay -f $cow "$@" | lolcat
}

function why() {
  lsof -nP -i4TCP:$1 | grep LISTEN
}

function replace() {
  ag -0 -l $1 | xargs -0 sed -i "" -e "s/$1/$2/g"
}

alias ff='findfile'
alias ag='ag --path-to-ignore ~/.ignore'
alias gg='ag -i'


#. /Users/skylar/workspace/distro/install/bin/torch-activate

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
# [[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
# [[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh


# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Performance optimzations
DISABLE_UPDATE_PROMPT=true

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"

# Perform compinit only once a day.
autoload -Uz compinit

setopt EXTENDEDGLOB
for dump in $ZSH_COMPDUMP(#qN.m1); do
  compinit
  if [[ -s "$dump" && (! -s "$dump.zwc" || "$dump" -nt "$dump.zwc") ]]; then
    zcompile "$dump"
  fi
  echo "Initializing Completions..."
done
unsetopt EXTENDEDGLOB
compinit -C


# zprof
# Install Ruby Gems to ~/gems
export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH
