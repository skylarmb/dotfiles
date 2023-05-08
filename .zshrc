# profile shell startup time
if [[ -n "$DEBUG_ZPROF" ]]; then
  zmodload zsh/zprof
fi
zmodload zsh/parameter

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
export POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ---------------- SHELL ----------------

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
# DISABLE_UPDATE_PROMPT="true"

# compinit, runs once a day
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

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
export GPG_TTY=$(tty)
export PERIOD="1"
export EDITOR='nvim'
export LESS='--RAW-CONTROL-CHARS'
if command -v lesspipe.sh &>/dev/null; then
  export LESSOPEN='|~/.lessfilter %s'
fi
if command -v bat &>/dev/null; then
  export BAT_THEME="gruvbox-light"
  export BAT_CMD="bat --theme=$BAT_THEME --plain"
  export PAGER="$BAT_CMD"
  export MANPAGER="$BAT_CMD"
fi

# PATH
export ANDROID_HOME="~/Library/Android/sdk"
export GIT_EDITOR="$EDITOR"
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
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# config
export BAT_PAGER="less -F -x4"
export PYTHONWARNINGS="ignore"
export FZF_ALT_C_COMMAND="fd --ignore-file .gitignore -t d"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
export FZF_CTRL_R_OPTS="--reverse --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
export BAT_PREVIEW_COMMAND="bat --color=always --line-range :500 {}"
export FZF_DEFAULT_OPTS="--no-mouse --inline-info --border --multi --select-1 --exit-0 --preview='$BAT_PREVIEW_COMMAND'"
export TMUX_FZF_OPTIONS="-p -w 75% -h 75% -m"
export TMUX_FZF_WINDOW_FORMAT="[#{window_name}] #{pane_current_command}"
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins"

# custom vars
export NVIM_DAEMON_SOCK=~/.cache/nvim/server.sock
export DEFAULT_USER="$(whoami)"

# ---------------- ALIAS ----------------

alias vd='nvim_d'
alias v='nvim'
alias vi='nvim' # dont open mega-broken vi/vim
alias vim='nvim' # dont open mega-broken vi/vim
alias vo='fzf_edit_file'
alias vc='fzf_edit_grep'
alias q='exit'
alias qq='q'
alias qa='q'
alias :q='q'
alias :qa='q'
alias tt="nvim +'execute \"ToDoTxtTasksToggle\" | wincmd o'"
alias tn="nvim +'execute \"ToDoTxtTasksToggle\" | wincmd o | execute \"ToDoTxtTasksCapture\"'"

alias workspace='cd $WORKSPACE'
alias dotfiles='cd ~/dotfiles'
alias vimc='cd ~/.config/nvim && nvim'
alias zc='v ~/.zshrc && exec zsh'
alias gitc='v ~/.gitconfig'
alias zcp='v ~/.private/.zshrc && exec zsh'
alias alc='v ~/.config/alacritty/alacritty.yml'
alias tc='v ~/.tmux.conf'
alias zu='exec zsh'
alias dka='docker kill $(docker ps -q)'
alias vimwipe='rm -rf $HOME/.vim/tmp/swap; mkdir -p $HOME/.vim/tmp/swap'
alias g='git'
alias cc='git rev-parse HEAD | pbcopy'
alias unwip='git reset --soft HEAD~'
alias vm='v `git --no-pager diff --name-only --diff-filter=U`'
alias todo='gg "todo before"'
alias installglobals='npm install -g prettier diff-so-fancy neovim npm-why serve serverless nodemon markdown-toc ts-node lebab'
alias scr='v $WORKSPACE/scratchpad/scratch.tsx'
# alias ccat='cat'
alias cat='bat --style=plain,header,grid'
alias ccat='command cat'
alias c='command'
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
alias ta='tmux new-session -A -s main -t main'
alias psg='ps aux | grep'

# ---------------- PLUGINS ----------------
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
export NVM_AUTO_USE=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('vim', 'nvim', 'v')
export NVM_DIR="$HOME/.nvm"
# this is overwritten later by nvm lazy load
export NVM_DEFAULT="$(cat $NVM_DIR/alias/default)"
export NVM_BIN="$NVM_DIR/versions/node/v$NVM_DEFAULT/bin"
export PATH="$NVM_BIN:$PATH"

# source $HOME/antigen.zsh
#
# if [[ -n "$DEBUG_ANTIGEN" ]]; then
#   cat $ANTIGEN_LOG
# fi
# If there is cache available
if [[ -f ${ADOTDIR:-$HOME/.antigen}/.cache/.zcache-payload ]]; then
    # Load bundles statically
    source ${ADOTDIR:-$HOME/.antigen}/.cache/.zcache-payload
    # You will need to call compinit
    # autoload -Uz compinit
    # compinit -d ${HOME}/.zcompdump
else
    # If there is no cache available, load normally and create cache
    source $HOME/antigen.zsh
    antigen init $HOME/.antigenrc
fi

bindkey '^Xh' _complete_help
# bindkey '\t' autosuggest-accept

zstyle ':completion:*'                accept-exact '*(N)'
zstyle ':completion:*'                use-cache yes
zstyle ':completion::complete:*'      cache-path ~/
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions'   format '[%d]'
zstyle ':completion:*'                list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:*:*'        fzf-preview 'less ${(Q)realpath}'
zstyle ':fzf-tab:*'                   continuous-trigger 'tab'
zstyle ':fzf-tab:*'                   accept-line enter
zstyle ':fzf-tab:*'                   switch-group ',' '.'
zstyle ':fzf-tab:*:'                  prefix ''
zstyle ':fzf-tab:*:'                  fzf-min-height 20
zstyle ':fzf-tab:*:'                  fzf-pad 4
zstyle ':fzf-tab:*'                   popup-min-size "$(($(tput cols) - 10))" 20
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
enable-fzf-tab

# ---------------- FUNCTIONS ----------------

vbin(){
  $EDITOR "$HOME/.local/bin/$1"
}

eslw(){
  esw . --cache --color --watch --clear --ext .ts,.tsx,.js,.jsx,.json --quiet "${@}"
}

# Run the command given by "$@" in the background
silent_background() {
  setopt local_options no_notify no_monitor
  "$@" &|
}

switch_to_app() {
  osascript -e "tell application \"${1}\"" -e 'activate' -e 'end tell'
}

alias ff='fd'
alias ls='_exa'
alias cls='clear;_exa'
alias clsa='clear;_exa -a'
alias lsa='_exa -lah'
_exa() {
  exa --all --oneline --group-directories-first "${@}"
}

t() {
  local d="${1}"
  [[ "${d}" =~ ^[0-9]+$ ]] && shift || d=1
  local t="${1:-.}"
  _exa -T -L$d $t
}

# alias vr='neovide_remote'
# neovide_remote() {
#   local pipe="/tmp/nvimsocket"
#   if [[ -S "$pipe" ]]; then
#     echo "found existing socket"
#     nvr --nostart --remote -p $@
#     switch_to_app Neovide
#   else
#     echo "no socket found, starting nvim_d"
#     nvim_d
#     neovide --multigrid --server $pipe -p
#   fi
# }

linkdot() {
  ln -s ~/dotfiles/$1 ~/$2
}

git_nvim(){
  local repo="$(git rev-parse --show-toplevel)"
  if [[ -z "$repo" ]]; then
    vo
  else
    git ls-files --full-name ${repo} | fzf
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

# v(){
#   if [[ -f "echo ~/.vim/tmp/swap/$(basename $@).swp" ]]
#   then
#     nvim -r $@
#   else
#     nvim $@
#   fi
# }


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

alias ws='cd_workspace'
cd_workspace() {
  if [[ ! -z "${@}" ]]
  then
    cd "${WORKSPACE}/${@}"
  else
    cd "${WORKSPACE}"
  fi
}

fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

fzf_query() {
  fzf --query="${@}"
}

# vim fuzzy open by filename with preview
fzf_edit_file() {
  file="$(fzf_query ${@})"
  # print to add to shell history, then edit it
  print -S "${EDITOR} ${file}" && $EDITOR "${file}"
}

# vim fuzzy open by file contents with preview and highlighted line
fzf_edit_grep() {
  $EDITOR $( \
    # workers however many cpu cores you have
    ag --noheading --nobreak . \
    | fzf \
      --delimiter=":" \
      --nth="2.." \
      --query="$@" \
      --preview="bat --color=always --highlight-line {2} {1}" \
      --preview-window '+{2}+3/2' \
    | awk -F ':' '{print $1" +"$2}' # open to specific line number
  )
}

# fbr - checkout git branch (including remote branches)
alias fbt='fzf_branches'
fzf_branches() {
  local branches branch
  branches=$(git branch --all --sort=-committerdate | grep -v -e HEAD -e remotes) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}


# fzf my PRs, return the PR number
fzf_pr_number() {
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

alias fpr='fzf_checkout_pr'
fzf_checkout_pr() {
  gh pr checkout "$(fzf_pulls)"
}

alias vl='fzf_last_commit'
fzf_last_commit() {
  v "$(git rev-parse --show-toplevel)/$(git diff HEAD^ HEAD --name-only | fzf)"
}

alias vpr='v $(fzf_all_pr_files)'
fzf_all_pr_files() {
  echo "$(git rev-parse --show-toplevel)/$(git diff master...HEAD --name-only | fzf)"
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
alias h='fzf_history'
fzf_history() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | gsed -r 's/ *[0-9]*\*? *//' | gsed -r 's/\\/\\\\/g')
}

# print (edit) history before running

alias hh='fzf_history_edit'
fzf_history_edit() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | gsed -r 's/ *[0-9]*\*? *//' | gsed -r 's/\\/\\\\/g')
}

randomsay() {
  cow=(`cowsay -l | tail -n +2 | tr  " "  "\n" | sort -R | head -n 1`)
  cowsay -f $cow "$@" | lolcat
}

alias why='grep_inuse_ports'
grep_inuse_ports() {
  if [[ -z "${1}" ]]; then
    lsof -nP -i4TCP:"${1}" | grep LISTEN
    return
  fi
  lsof -nP -i4TCP | grep LISTEN
}

replace() {
  ag -iQ -0 -l $1 | xargs -0 sed -i "" -e "s|$1|$2|g"
}

# ag / the_silver_searcher


export AG_DEFAULT_OPTS=(
  --literal
  --ignore-case
  --follow
  --width=500
  --context=2
  --group
  --heading
)




ag_default_cmd(){ ag "${AG_DEFAULT_OPTS[@]}" "${@}" ; }
alias gg='ag_default_cmd'
alias ggf='ag_default_cmd --files-with-matches'
alias gga='ag_with_context'
alias ggg='ag_default_cmd --skip-vcs-ignores'


ag_with_context(){
  local c="${1}"
  shift
}

help() {
  local c="${1}"
  [[ "${c}" =~ ^[0-9]+$ ]] && shift || c=10
  local cmd="${1}"
  shift
  local query="${@}"
  local sep="#$(printf -- '─%.0s' {1..80})"
  rg_query() { rg --color=never -NFi -C"${c}" --context-separator="${sep}" "${query}" "${1}" ; }
  batman() {
    bat -l man \
    --color=always \
    --style=numbers \
    --theme=$BAT_THEME \
    --wrap=never \
    --pager=never "${@}"
  }
  batman <(cat <<ENDHELP
${sep}
MANPAGE:
${sep}
$(rg_query <(man -Pcat "${cmd}" 2>/dev/null | col -b))
${sep}
HELP:
${sep}
$(rg_query <("${cmd}" --help || "${cmd}" -h || "${cmd}" -? | col -b))

ENDHELP

)
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

# export NVIM_LISTEN_ADDRESS="/tmp/nvim.sock"
# export NVR_CMD="nvim --headless"

_nvr="$(which nvr)"
nvr_socket="/tmp/nvim.sock"
nvrd() {
  nohup nvim --listen ${nvr_socket} --headless >/dev/null &
  nvim --server ${nvr_socket} --remote-send ":e /tmp/.KEEPALIVE<CR>:call KeepAlive()<CR>"
}

makebin() {
  local file="~/.local/bin/${1}"
  if [[ -f "${file}" ]]; then
    echo "Script ${file} already exists, editing instead"
    $EDITOR "${file}"
    return 1
  fi

  echo "#!/usr/bin/env bash" > "${file}"
  echo "# makebin generated script: ${1}, $(date)" >> "${file}"
  chmod +x "${file}"
  $EDITOR "${file}"
}

# get the hex bytes of a string, e.g. for getting tmux/alacritty key codes
gethex(){
  echo -n "${*}" | xxd -g 1
}

# Profiler
if [[ -n "$DEBUG_ZPROF" ]]; then
  zprof
fi
