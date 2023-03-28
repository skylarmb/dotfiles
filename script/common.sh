#!/usr/bin/env bash
set -euxo pipefail
DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
DOTFILES="$(cd "${DIR}" && git rev-parse --show-toplevel)"
DATE_FMT='+%Y-%m-%d %H:%M:%S'
LOGFILE="/var/log/bootstrap.log"

logger() {
  local script="$(basename ${1})"
  set +x
  while read -r line; do
    echo "[${script}] $(date "${DATE_FMT}"): ${line}"
  done
  set -x
}
