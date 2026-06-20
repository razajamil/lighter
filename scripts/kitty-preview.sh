#!/usr/bin/env bash
# Rebuild the kitty config and open a fresh kitty window using ONLY that theme
# (kitty falls back to defaults for any non-color setting). Good for a quick look
# without touching your real kitty config.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
"$ROOT/scripts/build.sh"
exec kitty --config "$ROOT/extras/kitty/lighter.conf"
