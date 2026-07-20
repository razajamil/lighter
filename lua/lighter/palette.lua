-- ============================================================================
-- lighter — BASE COLORS  (Layer 1: the single source of truth)
-- ============================================================================
-- Derived from the "glade" variant of koda.nvim (https://github.com/oskarnurm/koda.nvim).
--
-- This file is PURE DATA: just named hex colors, no logic, no `vim.*` calls.
-- Every application package (Neovim highlights, kitty, future terminals) is
-- built from these names — change a color here and rebuild, and it propagates
-- everywhere.
--
-- To restyle the theme, edit the hex values below. Keep the *names* stable;
-- the packaging layers refer to colors by name (e.g. `emphasis`, `string`).
--
-- Palette tuning note: accents are desaturated (reduced OKLCH chroma) so they
-- read soft/calm on the light background rather than vibrating, while keeping
-- WCAG luminance ~constant so text contrast stays at AA (~4.5:1 on `bg`).
-- ----------------------------------------------------------------------------

---@class lighter.Palette
local palette = {
  -- UI / surfaces ------------------------------------------------------------
  bg        = "#f7f7f7", -- editor / terminal background
  fg        = "#222222", -- default foreground text (soft black — gentler than pure #000 for long reading)
  dim       = "#bfd9d9", -- faint, low-contrast accents (e.g. whitespace)
  line      = "#e2eeee", -- cursorline, selection, subtle fills
  border    = "#9e9e9e", -- window/float borders, separators

  -- Syntax roles -------------------------------------------------------------
  keyword   = "#525252", -- keywords, statements
  type      = "#639094", -- types, delimiters
  operator  = "#639094", -- operators
  comment   = "#787878", -- comments, line numbers
  faint     = "#a9a9a9", -- de-emphasized text (e.g. TS import/export)
  emphasis  = "#4461a2", -- titles, returns, links (the "accent" blue)
  func      = "#4461a2", -- function names
  string    = "#4e7c3f", -- strings
  char      = "#a65e41", -- characters
  special   = "#a65e41", -- identifiers, special chars
  const     = "#a65e41", -- constants, numbers, booleans

  -- Diagnostic / status semantics -------------------------------------------
  highlight = "#96672e", -- attention / matched text
  info      = "#3d74a7", -- info / hints
  success   = "#4e7c3f", -- success / additions
  warning   = "#96672e", -- warning / changes
  danger    = "#b25644", -- error / deletions

  -- Raw accent hues (for terminal ANSI + ad-hoc use) -------------------------
  green     = "#4e7c3f",
  orange    = "#9b643a",
  red       = "#9e443d",
  pink      = "#a65e41",
  cyan      = "#407894",
}

return palette
