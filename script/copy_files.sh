#!/usr/bin/env bash
set -euxo pipefile
DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
source "${DIR}/common.sh"

# some tools, notably pnpm and brew, don't work with symlinked config files so
# files are copied instead
copy_files() {
  declare -a files=(
    prettierrc.json
    Brewfile
    package.json
    pnpm-lock.yaml
    requirements.txt
  )
  for file in "${files[@]}"; do
    local src="${DOTFILES}/${file}"
    local dst="${HOME}/${file}"
    cp "${src}" "${dst}"
    ls -lah "${dst}"
  done
}

link_dotfiles 2>&1 | logger "${BASH_SOURCE[0]}"
