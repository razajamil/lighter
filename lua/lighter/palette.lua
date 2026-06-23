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
  border    = "#9e9e9e", -- window/float borders, separators

  -- Syntax roles -------------------------------------------------------------
  keyword   = "#525252", -- keywords, statements
  type      = "#5b9196", -- types, delimiters
  operator  = "#5b9196", -- operators
  comment   = "#787878", -- comments, line numbers
  faint     = "#a9a9a9", -- de-emphasized text (e.g. TS import/export)
  emphasis  = "#325cc0", -- titles, returns, links (the "accent" blue)
  func      = "#325cc0", -- function names
  string    = "#3e8024", -- strings
  char      = "#c34b0a", -- characters
  special   = "#c34b0a", -- identifiers, special chars
  const     = "#c34b0a", -- constants, numbers, booleans

  -- Diagnostic / status semantics -------------------------------------------
  highlight = "#a16400", -- attention / matched text
  info      = "#0075c4", -- info / hints
  success   = "#3e8024", -- success / additions
  warning   = "#a16400", -- warning / changes
  danger    = "#d13e23", -- error / deletions

  -- Raw accent hues (for terminal ANSI + ad-hoc use) -------------------------
  green     = "#3e8024",
  orange    = "#ac5d0e",
  red       = "#aa3731",
  pink      = "#c34b0a",
  cyan      = "#007aa6",
}

return palette
