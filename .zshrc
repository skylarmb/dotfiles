# Profiler
# zmodload zsh/zprof

# ---------------- SHELL ----------------
zmodload zsh/parameter
export XDG_CONFIG_HOME="$HOME/.config"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
export POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# use vim navigation
set -o vi
setopt +o nomatch

# increase the number of files a terminal session can have open
ulimit -n 16384

# dont prompt when rming glob patterns
setopt rmstarsilent

# zsh options
ZSH_DISABLE_COMPFIX="true"
# use hyphen-insensitive completion. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="false"
# display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
# Performance optimzations
DISABLE_UPDATE_PROMPT="true"

# compinit, runs once a day
setopt EXTENDEDGLOB LOCAL_OPTIONS
autoload -U compinit; compinit
zmodload -i zsh/complist
local zcd=${ZPLGM[ZCOMPDUMP_PATH]:-${ZDOTDIR:-$HOME}/.zcompdump}
local zcdc="$zcd.zwc"
if [[ -f "$zcd"(#qN.m+1) ]]; then
    echo "Performing zcompdump..."
    compinit -i -d "$zcd"
    { rm -f "$zcdc" && zcompile "$zcd" } &!
else
    compinit -C -d "$zcd"
    { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
fi
unsetopt EXTENDEDGLOB

# easily rename filenames to kebab-case
autoload -Uz zmv
autoload -Uz edit-command-line
bindkey "^X^E" edit-command-line
zstyle ':completion:*' completer _expand_alias _complete _ignored
export ZSH_EXPAND_ALL_DISABLE="word,alias"
bindkey "^X^X" expand-all

# ---------------- USER CONFIG ----------------

## Private
# .private should define:
# - $WORKSPACE
# - $GITHUB_TOKEN
# - $GITHUB_EMAIL
# - $TMUX_DEFAULT_PATH
# - $DOCKER_CERT_PATH, $DOCKER_HOST, $DOCKER_TLS_VERIFY, etc
if [ -d "$HOME/.private" ]; then
  source "$HOME/.private/.zshrc"
fi

# ---------------- ENV ----------------
fpath=($fpath "$HOME/.zfunctions")

# shell
export PERIOD="1"
export EDITOR='nvim'
export LESS='-FXr'
export GPG_TTY=$(tty)
if command -v bat &>/dev/null; then
  export BAT_CMD="bat --theme=gruvbox-dark --plain"
  export PAGER="$BAT_CMD"
  export MANPAGER="$BAT_CMD"
fi

# PATH
export ANDROID_HOME="~/Library/Android/sdk"
export GIT_EDITOR='nvim'
export GO111MODULE=on
export GOBIN="$GOPATH/bin";
export GOPATH="$HOME/go";
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
export MANPATH="/usr/local/man:$MANPATH"
export PATH="$HOME/.gem/bin:$PATH"
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$PATH:$GOBIN";
export PATH="$PATH:/Applications/Sublime Text.app/Contents/SharedSupport/bin"
export PATH="$PATH:/usr/local/go/bin"
# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# config
export BAT_PAGER="less -RF"
export PYTHONWARNINGS="ignore"
export FZF_ALT_C_COMMAND="fd --ignore-file .gitignore -t d"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
export FZF_CTRL_R_OPTS="--reverse --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
export FZF_DEFAULT_OPTS='--no-mouse --inline-info --border --multi --select-1 --exit-0'
export TMUX_FZF_OPTIONS="-p -w 75% -h 75% -m"
export TMUX_FZF_WINDOW_FORMAT="[#{window_name}] #{pane_current_command}"
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins"

# custom vars
export NVIM_DAEMON_SOCK=~/.cache/nvim/server.sock
export DEFAULT_USER="$(whoami)"

# ---------------- ALIAS ----------------

alias workspace='cd $WORKSPACE'
alias dotfiles='cd ~/dotfiles'
alias cls='clear;ls'
alias clsa='clear;ls -a'
alias lsa='ls -lah --color=always'
alias vimc='v ~/.vimrc'
alias zc='v ~/.zshrc && exec zsh'
alias zcp='v ~/.private/.zshrc && exec zsh'
alias alc='v ~/.config/alacritty/alacritty.yml'
alias tc='v ~/.tmux.conf'
alias zu='exec zsh'
alias dka='docker kill $(docker ps -q)'
alias t='tree -I node_modules -I .pnpm -I .git -laL'
alias ta='tmux a'
alias vimwipe='rm -rf $HOME/.vim/tmp/swap; mkdir -p $HOME/.vim/tmp/swap'
alias g='git'
alias cc='git rev-parse HEAD | pbcopy'
# alias v="nvim --server $NVIM_DAEMON_SOCK --remote"
alias unwip='git reset --soft HEAD~'
alias vm='v `git --no-pager diff --name-only --diff-filter=U`'
alias todo='gg "todo before"'
alias installglobals='npm install -g prettier diff-so-fancy neovim npm-why serve serverless nodemon markdown-toc ts-node lebab'
alias scr='v $WORKSPACE/scratchpad/scratch.tsx'
# alias ccat='cat'
alias cat="bat --style=plain,header,grid"
alias ccat="command cat"
alias c="command"
alias ff='fd'
# alias ag='ag --path-to-ignore ~/.ignore'
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
alias psg='ps aux | grep'

# ---------------- PLUGINS ----------------
# export ANTIGEN_LOG="$(mktemp -t antigen).log"
# echo "Logging to $ANTIGEN_LOG"

export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
export NVM_AUTO_USE=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('vim', 'nvim', 'v')
export NVM_DIR="$HOME/.nvm"
# this is overwritten later by nvm lazy load
export NVM_DEFAULT="$(cat $NVM_DIR/alias/default)"
export NVM_BIN="$NVM_DIR/versions/node/v$NVM_DEFAULT/bin"
export PATH="$NVM_BIN:$PATH"

source $HOME/antigen.zsh
antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
  unixorn/fzf-zsh-plugin --branch=main
  Aloxaf/fzf-tab
  Freed-Wu/fzf-tab-source --branch=main
  command-not-found
  lukechilds/zsh-nvm
  zsh-users/zsh-autosuggestions
  simnalamburt/zsh-expand-all

EOBUNDLES

antigen apply

# cat $ANTIGEN_LOG

bindkey '^Xh' _complete_help

zstyle ':completion:*'                accept-exact '*(N)'
zstyle ':completion:*'                use-cache yes
zstyle ':completion::complete:*'      cache-path ~/
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions'   format '[%d]'
zstyle ':completion:*'                list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:*'                   accept-line enter
zstyle ':fzf-tab:*'                   fzf-bindings 'tab:accept'
zstyle ':fzf-tab:*'                   switch-group ',' '.'
zstyle ':fzf-tab:*:'                  prefix ''
zstyle ':fzf-tab:sources'             config-directory $ANTIGEN_BUNDLES/Freed-Wu/fzf-tab-source
zstyle ':fzf-tab:*'                   fzf-preview 'env BAT_STYLE="numbers,header" bat {}'

# manually installed plugins
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# ---------------- FUNCTIONS ----------------

linkdot() {
  ln -s ~/dotfiles/$1 ~/$2
}

git_nvim(){
  local repo="$(git rev-parse --show-toplevel)"
  if [[ -z "$repo" ]]; then
    nvim $@
  fi
  local files="$(git ls-files --full-name $repo)"
  local file_count="$(echo "$files" | wc -l)"
  if [[ "$file_count" -eq 1 ]]; then
    nvim $files
  else
    nvim $(echo "$files" | fzf --multi --preview 'bat --color=always {}')
  fi
}

wip() {
  git add -A;
  git commit --no-verify -m "squash! ... WIP: ${*}"
}


# auto tmux window naming
tmux-window-name() {
  ($TMUX_PLUGIN_MANAGER_PATH/tmux-window-name/scripts/rename_session_windows.py &)
}

v(){
  if [[ -f "echo ~/.vim/tmp/swap/$(basename $@).swp" ]]
  then
    nvim -r $@
  else
    nvim $@
  fi
}


# auto tmux window naming
tmux-window-name() {
  if [[ -z "$TMUX" ]] || [[ -z "$TMUX_PLUGIN_MANAGER_PATH" ]]; then
    return
  fi
  ($TMUX_PLUGIN_MANAGER_PATH/tmux-window-name/scripts/rename_session_windows.py &)
}

# auto tmux window naming
if [ ! -z "$TMUX" ]; then
  tmux-window-name() {
    ($TMUX_PLUGIN_MANAGER_PATH/tmux-window-name/scripts/rename_session_windows.py &)
  }
  add-zsh-hook chpwd tmux-window-name
  add-zsh-hook periodic tmux-window-name
fi

ws() {
  if [[ ! -z "$@" ]]
  then
    cd "$WORKSPACE/$@"
  else
    cd "$WORKSPACE"
  fi
}

fzf_with_preview() {
  fzf \
    --query="$@" \
    --preview="bat --color=always --style=numbers --theme=gruvbox-dark {}"
}

fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

# vim fuzzy open by filename with preview
vo() {
  file=$(fzf_with_preview)
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
  v "$(git rev-parse --show-toplevel)/$(git diff HEAD^ HEAD --name-only | fzf)"
}

vpr() {
  v "$(git rev-parse --show-toplevel)/$(git diff master...HEAD --name-only | fzf)"
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
  if [[ -z "${1}" ]]; then
    lsof -nP -i4TCP | grep LISTEN
    return
  fi
  lsof -nP -i4TCP | grep LISTEN
}

replace() {
  ag -iQ -0 -l $1 -G $3 | xargs -0 sed -i "" -e "s|$1|$2|g"
}

# ag / the_silver_searcher
_ag_opts="--color -iQ --workers=10 --follow"
alias ggl='ag -iQl --width=500'
gg() { ag $_ag_opts "${@}" ; }
gga() { ag $_ag_opts --context 5 "${@}" ; }
ggg() { ag $_ag_opts --multiline --width=500 }


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

toggle_tmux_popup() {
  if [ "$(tmux display-message -p -F "#{session_name}")" = "popup" ];then
      tmux detach-client
  else
      tmux popup -d '#{pane_current_path}' -xC -yC -w80% -h75% -E "tmux attach -t popup || tmux new -s popup"
  fi
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme

# export NVIM_LISTEN_ADDRESS="/tmp/nvim.sock"
# export NVR_CMD="nvim --headless"

_nvr="$(which nvr)"
nvr_socket="/tmp/nvim.sock"
nvrd() {
  nohup nvim --listen ${nvr_socket} --headless >/dev/null &
  nvim --server ${nvr_socket} --remote-send ":e /tmp/.KEEPALIVE<CR>:call KeepAlive()<CR>"
}

vr() {
  echo "nvim PWD: $PWD"
  nvim --server ${nvr_socket} --remote "$@"
  nvim --server ${nvr_socket} --remote-ui
}


# Profiler
# zprof
