-- ============================================================================
-- lighter — Neovim highlight packaging
-- ============================================================================
-- Merges every highlight-group module into one table. Add new modules (plugin
-- integrations, etc.) by dropping a file in this directory and listing it here.
-- ----------------------------------------------------------------------------

local Utils = require("lighter.utils")

local M = {}

-- Loaded in order; later groups can `link` to earlier ones.
M.modules = {
  "base",       -- core editor UI (:h highlight-groups)
  "syntax",     -- legacy vim syntax (:h group-name)
  "treesitter", -- @-captures (:h treesitter-highlight)
  "lsp",        -- diagnostics + semantic tokens (:h lsp-highlight)
  "gitsigns",   -- gitsigns.nvim
}

--- Build the full highlight table from the palette + options.
---@param colors lighter.Palette
---@param opts lighter.Config
---@return table<string, table>
function M.setup(colors, opts)
  local hl = {}
  for _, name in ipairs(M.modules) do
    for group, spec in pairs(require("lighter.groups." .. name).get_hl(colors, opts)) do
      hl[group] = spec
    end
  end
  Utils.unpack(hl)
  if type(opts.on_highlights) == "function" then
    opts.on_highlights(hl, colors)
  end
  return hl
end

return M
