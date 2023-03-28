#!/usr/bin/env bash
set -euxo pipefile
DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
DOTFILES="$(cd "${DIR}" && git rev-parse --show-toplevel)"
DATE_FMT="+%Y-%m-%d %H:%M:%S"
LOGFILE="/var/log/bootstrap.log"

logger() {
  local prefix="${1}"
  while read -r line; do
    echo "[${prefix}] $(date ${DATE_FMT}): ${line}"
  done
}
