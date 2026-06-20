#!/usr/bin/env bash
# Launch Neovim with the lighter colorscheme active for testing.
# Opens the palette file by default; pass file paths to open them instead.
#   scripts/nvim-dev.sh [files...]
#
# Inside nvim, run `:LighterReload` after editing colors to see changes live.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ "$#" -eq 0 ]; then
  set -- "$ROOT/lua/lighter/palette.lua"
fi

exec nvim \
  --cmd "set runtimepath^=$ROOT" \
  --cmd "set termguicolors background=light" \
  -c "colorscheme lighter" \
  "$@"
