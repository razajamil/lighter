#!/usr/bin/env bash
# Rebuild the kitty config and live-apply it to ALL running kitty windows.
# Requires remote control: add `allow_remote_control yes` to kitty.conf, or
# launch kitty with `kitty -o allow_remote_control=yes`.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
"$ROOT/scripts/build.sh"
kitty @ set-colors --all --configured "$ROOT/extras/kitty/lighter.conf"
echo "lighter: applied to running kitty windows."
