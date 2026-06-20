#!/usr/bin/env bash
# Regenerate all application configs (kitty, …) from the base palette.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
nvim --headless --noplugin -l build/generate.lua
