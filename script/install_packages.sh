#!/usr/bin/env bash
set -euxo pipefile
DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
source "${DIR}/common.sh"

brew_install() {
  echo "Installing brew packages"
  cd "${HOME}"
  cp "${DOTFILES}/Brewfile" "${HOME}"
  echo "brew: $(brew --version)"
  echo "packages: $(cat Brewfile)"
  brew bundle install
}

pnpm_install() {
  echo "Installing node packages"
  cd "${HOME}"
  cp "${DOTFILES}/package.json" "${DOTFILES}/pnpm-lock.yaml" "${HOME}"
  echo "node: $(node --version)"
  echo "pnpm: $(pnpm --version)"
  echo "packages: $(cat packages.json)"
  pnpm install
}

pip_install() {
  cd "${HOME}"
  cp "${DOTFILES}/requirements.txt" "${HOME}"
  echo "Installing python packages"
  echo "python3: $(python3 --version)"
  echo "python2: $(python2 --version)"
  echo "packages: $(cat requirements.txt)"
  python3 -m pip install -r requirements.txt

  # echo "Installing ruby packages"
  # echo "ruby: $(ruby --version)"
}

go_install() {
  cd "${HOME}"
  echo "Installing go packages"
  echo "go: $(go version)"
  go install github.com/arl/gitmux@latest
}

"${1}" 2>&1 | logger "${BASH_SOURCE[0]}"
