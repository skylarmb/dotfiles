#!/usr/bin/env bash
set -euxo pipefile
DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
source "${DIR}/common.sh"

create_private() {
  local private="${DOTFILES}/.private"
  mkdir -p "${private}"

  echo "# bootstrap.sh: Generated - $(date ${DATE_FMT})
# private shell config, not for github
export GITHUB_TOKEN=fake
export WORKSPACE= # TODO
export TMUX_DEFAULT_PATH= # TODO
export GITHUB_EMAIL= # TODO
export DOTFILES=${DOTFILES}
" >> "${private}/.zshrc"

  echo "# bootstrap.sh: Generated - $(NOW)
# private git config, not for github
[user]
  name = Skylar Brown
  email = TODO-${USER}@skylar.xyz
" >> "${private}/.gitconfig"
}

create_private 2>&1 | logger "${BASH_SOURCE[0]}"
