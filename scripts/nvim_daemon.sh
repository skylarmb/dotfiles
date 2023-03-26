#!/bin/bash
set -euo pipefail

if pgrep nvim_daemon.sh >/dev/null; then
  echo "nvim_daemon: already running..."
fi

# Start the daemon
echo "nvim_daemon: starting..."
bash -c "nohup sh -c 'nvim --listen ~/.cache/nvim/server.pipe > ~/.cache/nvim/server.log 2>&1 &' &"
echo "nvim_daemon: pid $(pgrep nvim)"
