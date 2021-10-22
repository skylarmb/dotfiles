#!/bin/bash
# Profiler
# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '

# logfile=$(mktemp zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
# exec 3>&2 2>$logfile

# setopt XTRACE

# use vim navigation
set -o vi
setopt +o nomatch

# private stuff that doesn't get pushed to github
source "$HOME/.private"
# zmodload zsh/zprof
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
RPROMPT='%D{%r}'
ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export GPG_TTY=$(tty)

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
TYPEWRITTEN_CURSOR="block"
ZSH_THEME="typewritten"

# use hyphen-insensitive completion. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="false"

# display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# export NVM_LAZY_LOAD=true
# plugins=(zsh-autosuggestions zsh-nvm)

export MANPATH="/usr/local/man:$MANPATH"
export ANDROID_HOME="~/Library/Android/sdk"
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$GOPATH/bin"
# export PATH="$PATH:~/.nvm/versions/node/v14.16.0/bin"
export GO111MODULE=on
source $ZSH/oh-my-zsh.sh
# forgit
forgit_diff=gdd
forgit_add=gaa
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# increase the number of files a terminal session can have open
ulimit -n 2560

export EDITOR='nvim'
export GIT_EDITOR='nvim'
export DEFAULT_USER="$(whoami)"
export FZF_DEFAULT_COMMAND='ag -l -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --ignore-file .gitignore -t d"
# export LESS='-FXr'

# Install Ruby Gems to ~/.gems
export GEM_HOME=$HOME/.gem
export GEM_PATH=$HOME/.gem
export PATH=$HOME/.gem/bin:$PATH

alias ws=workspace
alias dotfiles='cd ~/dotfiles'
alias cls='clear;ls'
alias clsa='clear;ls -a'
alias lsa='ls -lah'
alias vimc='v ~/.vimrc'
alias zshc='v ~/.zshrc'
alias zshp='v ~/.private'
alias zshup='source ~/.zshrc'
alias killdocker='docker kill $(docker ps -q)'
alias t='tree -I node_modules -L'
alias ta='tmux a #'
alias vimwipe='rm -rf ~/.vim/tmp/backup/{*,.*}; rm -rf ~/.vim/tmp/swap/{*,.*}'
alias g='git'
alias c='git commit -m'
alias cc='git rev-parse HEAD | pbcopy'
alias s='subl'
alias v='nvim'
alias wip='git add . && git commit --no-verify -m wip'
alias unwip='git reset --soft HEAD~'
alias vm='nvim `git --no-pager diff --name-only --diff-filter=U`'
alias vo='nvim $(fzf --preview "bat --color=always --style=numbers --line-range=:500 {}")'
alias todo='gg "todo before"'
alias installglobals='npm install -g prettier diff-so-fancy neovim npm-why serve serverless nodemon markdown-toc ts-node lebab'
alias scr='nvim ~/scratch.tsx'
alias cat='bat'
alias ff='fd'
alias ag='ag --path-to-ignore ~/.ignore'
alias gg='ag -iQ'
alias ggg='ag -i --multiline'
alias ggl='ag -iQl'

# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all --sort=-committerdate | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

vc() {
  nvim $(ag --nobreak --noheading . | fzf --reverse | awk -F ':' '{print $1" +"$2}')
}

dns() {
    curl -sI $1 | grep -E '(301|302|Server|Location|X-Cache|HTTP)'
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
  ag -0 -l $1 | xargs -0 sed -i "" -e "s|$1|$2|g"
}

function gga() {
  ag -iQ -A $1 -B $1 $2
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Performance optimzations
DISABLE_UPDATE_PROMPT=true

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc

# # Perform compinit only once a day.

setopt EXTENDEDGLOB LOCAL_OPTIONS
autoload -Uz compinit
autoload -Uz bashcompinit && bashcompinit
zmodload -i zsh/complist

local zcd=${ZPLGM[ZCOMPDUMP_PATH]:-${ZDOTDIR:-$HOME}/.zcompdump}
local zcdc="$zcd.zwc"
if [[ -f "$zcd"(#qN.m+1) ]]; then
    compinit -i -d "$zcd"
    { rm -f "$zcdc" && zcompile "$zcd" } &!
else
    compinit -C -d "$zcd"
    { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
fi
unsetopt EXTENDEDGLOB
compinit -C
# caching
# zstyle ':completion:*' accept-exact '*(N)'

# zstyle ':completion:*'            use-cache yes
# zstyle ':completion::complete:*'  cache-path ~/

# zprof


# Profiler
# unsetopt XTRACE
# exec 2>&3 3>&-

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
eval "$(pyenv virtualenv-init -)"

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
    zle redisplay
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

autoload -U edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
