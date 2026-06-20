-- ============================================================================
-- lighter — Neovim config (options for the nvim package only)
-- ============================================================================
local M = {}

---@class lighter.Config
M.defaults = {
  -- Use "none" backgrounds so the terminal shows through.
  transparent = false,

  -- Per-role text styles applied on top of colors.
  styles = {
    functions = { bold = true },
    keywords  = {},
    comments  = {},
    strings   = { italic = true },
    constants = {},
  },

  -- Override base palette colors at setup time, e.g. colors = { emphasis = "#1f6feb" }.
  colors = {},

  -- Last-mile hook to tweak/extend highlight groups: fn(highlights, colors).
  on_highlights = function(_highlights, _colors) end,
}

M.options = vim.deepcopy(M.defaults)

---@param opts lighter.Config|nil
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
