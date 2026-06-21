#!/usr/bin/env bash
# Regenerate all application configs (kitty, …) from the base palette.
# Prefers a standalone Lua (dependency-light, used in CI); falls back to Neovim.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
for lua in luajit lua5.4 lua5.3 lua5.1 lua; do
  if command -v "$lua" >/dev/null 2>&1; then
    exec "$lua" build/generate.lua
  fi
done
exec nvim --headless --noplugin -l build/generate.lua
