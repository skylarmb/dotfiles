# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zmodload zsh/parameter
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*'            use-cache yes
zstyle ':completion::complete:*'  cache-path ~/

# Profiler
# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '
# logfile=$(mktemp zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
# exec 3>&2 2>$logfile
# setopt XTRACE
# zmodload zsh/zprof

# zsh options
ZSH_DISABLE_COMPFIX=true
# use hyphen-insensitive completion. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="false"
# display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
# Performance optimzations
DISABLE_UPDATE_PROMPT=true


# use vim navigation
set -o vi
setopt +o nomatch

# dont prompt when rming glob patterns
setopt rmstarsilent

source "$HOME/.private/.zshrc"

## Theme
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="powerlevel10k/powerlevel10k"

## Plugins
# export NVM_LAZY_LOAD=true
# plugins=(zsh-autosuggestions zsh-nvm)
# zmv: rename filenames to kebab-case
autoload -Uz zmv

## Environment variables
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
export GPG_TTY=$(tty)
export NODE_OPTIONS="--max-old-space-size=16384"
export MANPATH="/usr/local/man:$MANPATH"
export ANDROID_HOME="~/Library/Android/sdk"
export GOPATH="$HOME/go";
export GOBIN="$GOPATH/bin";
export PATH="$PATH:$GOBIN";
export PATH="$PATH:/usr/local/go/bin"
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$PATH:/Applications/Sublime Text.app/Contents/SharedSupport/bin"
export PERIOD="1"
# export PATH="$PATH:~/.nvm/versions/node/v14.16.0/bin"
export GO111MODULE=on
source $ZSH/oh-my-zsh.sh
# forgit
forgit_diff=gdd
forgit_add=gaa

export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

# increase the number of files a terminal session can have open
ulimit -n 2560

export EDITOR='nvim'
export GIT_EDITOR='nvim'
export NVIM_DAEMON_SOCK=~/.cache/nvim/server.sock
export DEFAULT_USER="$(whoami)"
export FZF_DEFAULT_OPTS='--no-mouse --layout=reverse --border'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --ignore-file .gitignore -t d"
export TMUX_FZF_OPTIONS="-p -w 75% -h 75% -m"
export TMUX_FZF_WINDOW_FORMAT="[#{window_name}] #{pane_current_command}"

# export LESS='-FXr'

export PATH=$HOME/.gem/bin:$PATH

alias workspace='cd $WORKSPACE'
alias dotfiles='cd ~/dotfiles'
alias cls='clear;ls'
alias clsa='clear;ls -a'
alias lsa='ls -lah'
alias vimc='v ~/.vimrc'
alias zc='v ~/.zshrc'
alias zcp='v ~/.private/.zshrc'
alias tc='v ~/.tmux.conf'
alias zu='source ~/.zshrc'
alias dka='docker kill $(docker ps -q)'
alias t='tree -I node_modules -I .pnpm -I .git -laL'
alias ta='tmux a #'
alias v='nvim'
alias vimwipe='rm -rf ~/.vim/tmp/backup/**; rm -rf ~/.vim/tmp/swap/**'
alias g='git'
alias cc='git rev-parse HEAD | pbcopy'
# alias v="nvim --server $NVIM_DAEMON_SOCK --remote"
alias unwip='git reset --soft HEAD~'
alias vm='v `git --no-pager diff --name-only --diff-filter=U`'
alias todo='gg "todo before"'
alias installglobals='npm install -g prettier diff-so-fancy neovim npm-why serve serverless nodemon markdown-toc ts-node lebab'
alias scr='v $WORKSPACE/scratchpad/scratch.tsx'
alias cat='bat'
alias ff='fd'
# alias ag='ag --path-to-ignore ~/.ignore'
alias gg='ag -iQ --width=500'
alias ggg='ag -i --multiline --width=500'
alias ggl='ag -iQl --width=500'
alias notes='cd ~/notes'
alias aa='cp ~/notes/all_around.template.md ~/notes/candidates/new.md && v ~/notes/candidates/new.md'
alias todo='v ~/notes/life.todo.md'
alias fgf='fg %$(jobs | fzf | grep -Eo "[0-9]{1,}" | head -1)'
alias p='pnpm'
alias pi='pnpm install'
alias plr='git checkout origin/master **/pnpm-lock.yaml && pnpm install'
alias prs='gh pr status'
alias w='~/.tmux/plugins/tmux-fzf/scripts/window.sh switch'
alias tn='tmux attach || tmux new'

function wip() {
  git add -A;
  git commit --no-verify -m "squash! ... WIP: ${*}"
}

# Git commit
function c() {
  git commit --no-verify -m "$@"
  git push --no-verify origin HEAD
}

# auto tmux window naming
tmux-window-name() {
  ($TMUX_PLUGIN_MANAGER_PATH/tmux-window-name/scripts/rename_session_windows.py &)
}

add-zsh-hook chpwd tmux-window-name
add-zsh-hook periodic tmux-window-name

ws() {
  if [[ ! -z "$@" ]]
  then
    cd "$WORKSPACE/$@"
  else
    cd "$WORKSPACE"
  fi
}

# vim fuzzy open by filename with preview
vo() {
  file=$( \
    fzf \
      --query="$@" \
      --preview="bat --color=always --style=numbers --theme=gruvbox-dark {}" \
  )
  print -S "v $file" && v $file
}

# vim fuzzy open by file contents with preview and highlighted line
vc() {
  v $( \
    # workers however many cpu cores you have
    ag --noheading --nobreak . \
    | fzf \
      --delimiter=":" \
      --nth="2.." \
      --query="$@" \
      --preview="bat --style=numbers --color=always --theme=gruvbox-dark --highlight-line {2} {1}" \
      --preview-window '+{2}+3/2' \
    | awk -F ':' '{print $1" +"$2}' # open to specific line number
  )
}

# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all --sort=-committerdate | grep -v -e HEAD -e remotes) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}


# fzf my PRs, return the PR number
fzfpr() {
  local pr ghprs
  ghprs="$(GH_FORCE_TTY='50%' gh pr list --author @me)"
  pr=$( \
    echo "$ghprs" | \
    fzf \
      --ansi \
      --header-lines 3 \
      --preview 'GH_FORCE_TTY=$FZF_PREVIEW_COLUMNS gh pr view {1}' \
  )
  echo "$(echo "$pr" | awk '{print $1}')"
}

fpr() {
  gh pr checkout "$(fzfpr)"
}

opr() {
  gh pr checkout "$(fzfpr)"
}

vl() {
  v $(git diff HEAD^ HEAD --name-only | fzf)
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

randomsay() {
  cow=(`cowsay -l | tail -n +2 | tr  " "  "\n" | sort -R | head -n 1`)
  cowsay -f $cow "$@" | lolcat
}

why() {
  lsof -nP -i4TCP:$1 | grep LISTEN
}

replace() {
  ag -iQ -0 -l $1 -G $3 | xargs -0 sed -i "" -e "s|$1|$2|g"
}

gga() {
  ag -iQ -A $1 -B $1 $2
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}


es6() {
  lebab $1 -o $1 --transform commonjs
  lebab $1 -o $1 --transform no-strict
  lebab $1 -o $1 --transform obj-shorthand
  lebab $1 -o $1 --transform let
  lebab $1 -o $1 --transform arrow
  lebab $1 -o $1 --transform arrow-return
}

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# source /usr/share/nvm/init-nvm.sh

# auto-detect and use .nvmrc files when changing directory
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
  # corepack enable && corepack prepare pnpm@latest --activate
}
add-zsh-hook chpwd load-nvmrc

# Perform compinit only once a day.

# setopt EXTENDEDGLOB LOCAL_OPTIONS
# autoload -Uz compinit
# autoload -Uz bashcompinit && bashcompinit
# zmodload -i zsh/complist

# local zcd=${ZPLGM[ZCOMPDUMP_PATH]:-${ZDOTDIR:-$HOME}/.zcompdump}
# local zcdc="$zcd.zwc"
# if [[ -f "$zcd"(#qN.m+1) ]]; then
#     compinit -i -d "$zcd"
#     { rm -f "$zcdc" && zcompile "$zcd" } &!
# else
#     compinit -C -d "$zcd"
#     { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
# fi
# unsetopt EXTENDEDGLOB

# compinit -C
# caching
# Profiler
# unsetopt XTRACE
# exec 2>&3 3>&-

# tabtab source for packages
# uninstall by removing these lines
# [[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

export PATH="$HOME/.pyenv/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
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


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

fpath=($fpath "$HOME/.zfunctions")

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
