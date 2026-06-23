-- ============================================================================
-- lighter — Neovim entry point
-- ============================================================================
-- The Neovim "package": turns the base palette into live highlight groups.
-- Activated by `colors/lighter.lua` (i.e. `:colorscheme lighter`).
-- ----------------------------------------------------------------------------

local M = {}

--- Optional setup; only needed to pass options. `:colorscheme lighter` works
--- without it.
---@param opts lighter.Config|nil
function M.setup(opts)
  require("lighter.config").setup(opts)
  vim.api.nvim_create_user_command("LighterReload", function()
    require("lighter.utils").reload()
  end, { desc = "Reload the lighter colorscheme from source" })
end

--- The base palette with any user `colors = {}` overrides merged in.
---@return lighter.Palette
function M.get_palette()
  local palette = require("lighter.palette")
  local config = require("lighter.config")
  if type(config.options.colors) == "table" then
    palette = vim.tbl_deep_extend("force", palette, config.options.colors)
  end
  return palette
end

--- Apply the colorscheme.
function M.load()
  local config = require("lighter.config")
  local groups = require("lighter.groups")
  local palette = M.get_palette()

  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  vim.o.termguicolors = true
  vim.o.background = "light"
  vim.g.colors_name = "lighter"

  -- Expose :LighterReload whenever the colorscheme is active — works even when
  -- the plugin spec never calls setup() (e.g. a bare LazyVim colorscheme entry).
  vim.api.nvim_create_user_command("LighterReload", function()
    require("lighter.utils").reload()
  end, { desc = "Reload the lighter colorscheme from source" })

  for group, hl in pairs(groups.setup(palette, config.options)) do
    vim.api.nvim_set_hl(0, group, hl)
  end
end

return M
