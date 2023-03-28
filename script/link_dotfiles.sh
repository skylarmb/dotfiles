#!/usr/bin/env bash
set -euxo pipefile
DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
source "${DIR}/common.sh"

_symlink() {
  declare -a files=("${@}")
  for file in "${files[@]}"; do
    local src="${DOTFILES}/${file}"
    local dst="${HOME}/$(basename ${file})"
    ln -s "${src}" "${dst}" || _log "File exists: ${dst}"
    ls -lah "${dst}"
  done
}

link_dotfiles() {
  declare -a universal=(
    .config
    .private
    .vim
    .tmux
    .zshrc
    .zprofile
    .gitconfig
    .gitignore_global
    .gitmodules
    .gitmux.conf
    .nvmrc
    .vimrc
    .ideavimrc
    .tmux.conf
    .fzf.zsh
    .p10k.zsh
  )

  declare -a darwin=(
    .fzf.zsh
  )

  declare -a linux=(
    linux/.fzf.zsh
  )

  _symlink $universal

  kernel_name=$(uname -s)
  if [[ "${kernel_name}" == "Linux" ]]; then
    _symlink $linux
  elif [[ "${kernel_name}" == "Darwin" ]]; then
    _symlink $darwin
  else
    _log "Unknown operating system: ${kernel_name}"
    exit 1
  fi
}

link_dotfiles 2>&1 | logger "${BASH_SOURCE[0]}"
