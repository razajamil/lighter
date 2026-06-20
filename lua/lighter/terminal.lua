-- ============================================================================
-- lighter — TERMINAL package  (Layer 2: shared across all terminal emulators)
-- ============================================================================
-- Maps the base palette to a 16-color ANSI set + special slots (cursor,
-- selection, borders, tabs). Every terminal target (kitty today; ghostty,
-- wezterm, … later) formats THIS table into its own syntax, so there's one
-- ANSI mapping to maintain, not one per emulator.
--
-- Light-background convention: the ANSI "black" slots (0/8) map to light
-- neutrals and the "white" slots (7/15) map to dark text, so program output
-- using default colors stays legible on the light background.
-- ----------------------------------------------------------------------------

local p = require("lighter.palette")
local blend = require("lighter.utils").blend

local M = {}

-- Special, non-ANSI slots.
M.special = {
  foreground           = p.fg,
  background           = p.bg,
  selection_foreground = p.fg,
  selection_background = p.line,
  cursor               = p.keyword,
  cursor_text          = p.bg,
  url                  = p.emphasis,
  border_active        = p.emphasis,
  border_inactive      = p.border,
  border_bell          = p.warning,
  tab_active_fg        = p.fg,
  tab_active_bg        = p.bg,
  tab_inactive_fg      = p.comment,
  tab_inactive_bg      = p.line,
  tab_bar_bg           = p.line,
}

-- The 16 ANSI colors (index 0..15). Brights derive from the base hues.
M.ansi = {
  [0]  = p.line,                      -- black   → light neutral
  [1]  = p.red,                       -- red
  [2]  = p.green,                     -- green
  [3]  = p.warning,                   -- yellow
  [4]  = p.emphasis,                  -- blue
  [5]  = p.pink,                      -- magenta
  [6]  = p.cyan,                      -- cyan
  [7]  = p.keyword,                   -- white   → dark gray
  [8]  = p.border,                    -- br black
  [9]  = p.danger,                    -- br red
  [10] = blend(p.green, p.fg, 0.85),  -- br green  (base hue, slightly deepened)
  [11] = p.orange,                    -- br yellow → orange
  [12] = p.info,                      -- br blue
  [13] = blend(p.pink, p.fg, 0.85),   -- br magenta (base hue, slightly deepened)
  [14] = blend(p.cyan, p.fg, 0.85),   -- br cyan    (base hue, slightly deepened)
  [15] = p.fg,                        -- br white → black
}

return M
