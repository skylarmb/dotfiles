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

# thefuck
eval $(thefuck --alias)

# NVM
export NVM_DIR="/home/skylar/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# export MANPATH="/usr/local/man:$MANPATH"
export ANDROID_HOME="~/Library/Android/sdk"
export PATH="$HOME/bin:/usr/local/bin:$HOME/.rbenv/bin:$HOME/.rbenv/shims/:$PATH:$ANDROID_HOME:$(yarn global bin)"
export GOPATH="$HOME/workspace/go"
source $ZSH/oh-my-zsh.sh

# increase the number of files a terminal session can have open
ulimit -n 2560

export EDITOR='vim'
export GIT_EDITOR='vim'
export DEFAULT_USER="$(whoami)"
export LESS='-FXr'

alias workspace='cd ~/workspace'
alias ws=workspace
alias cls='clear;ls'
alias bi='bundle install --binstubs .bundle/bin'
alias clsa='clear;ls -a'
alias lsa='ls -lah'
alias killrails='rm ~/**/tmp/pids/server.pid; sudo lsof -iTCP -sTCP:LISTEN -P | grep :3000'
alias killmail='sudo lsof -iTCP -sTCP:LISTEN -P | grep :1080; sudo lsof -iTCP -sTCP:LISTEN -P | grep :1025'
eval "$(rbenv init -)"
alias zozi='cd ~/workspace/zozi'
alias mobile='cd ~/workspace/ZoziMobile'
alias cms='cd ~/workspace/cms'
alias chef='cd ~/workspace/chef'
alias comfy='cd ~/workspace/gems/comfortable-mexican-sofa'
alias fortress='cd ~/workspace/cms-fortress'
alias wordpress='cd ~/workspace/wordpress-heroku'
alias sitebuilder='cd ~/workspace/sitebuilder'
alias comfy='cd ~/workspace/gems/comfortable-mexican-sofa'
alias fortress='cd ~/workspace/gems/cms-fortress'
alias galaxy='cd ~/workspace/galaxy'
alias sr='spring rails s'
alias sc='spring rails c'
alias g='git'
alias rake='noglob bundle exec rake'
alias zshup='source ~/.zshrc'
alias goproj='cd ~/workspace/go/src/github.com/skylarmb/goplay'
alias killaccel='defaults write .GlobalPreferences com.apple.mouse.scaling -1'
alias reaccel='defaults write .GlobalPreferences com.apple.mouse.scaling 2'
alias ai='sudo apt install -y'
alias au='sudo apt update'

findfile() {
  find . -name "*$1*"
}
alias ff='findfile'
alias gg='ag'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
