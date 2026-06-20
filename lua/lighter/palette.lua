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
-- ----------------------------------------------------------------------------

---@class lighter.Palette
local palette = {
  -- UI / surfaces ------------------------------------------------------------
  bg        = "#f7f7f7", -- editor / terminal background
  fg        = "#000000", -- default foreground text
  dim       = "#bfd9d9", -- faint, low-contrast accents (e.g. whitespace)
  line      = "#e2eeee", -- cursorline, selection, subtle fills
  border    = "#999999", -- window/float borders, separators

  -- Syntax roles -------------------------------------------------------------
  keyword   = "#525252", -- keywords, statements
  type      = "#708b8d", -- types, delimiters
  operator  = "#708b8d", -- operators
  comment   = "#696969", -- comments, line numbers
  faint     = "#9a9a9a", -- de-emphasized text (e.g. TS import/export)
  emphasis  = "#325cc0", -- titles, returns, links (the "accent" blue)
  func      = "#325cc0", -- function names
  string    = "#448c27", -- strings
  char      = "#7a3e9d", -- characters
  special   = "#7a3e9d", -- identifiers, special chars
  const     = "#7a3e9d", -- constants, numbers, booleans

  -- Diagnostic / status semantics -------------------------------------------
  highlight = "#bc7500", -- attention / matched text
  info      = "#007acc", -- info / hints
  success   = "#448c27", -- success / additions
  warning   = "#bc7500", -- warning / changes
  danger    = "#d13e23", -- error / deletions

  -- Raw accent hues (for terminal ANSI + ad-hoc use) -------------------------
  green     = "#448c27",
  orange    = "#ec8013",
  red       = "#aa3731",
  pink      = "#7a3e9d",
  cyan      = "#0083b2",
}

return palette
