-- ============================================================================
-- lighter — utilities
-- ============================================================================
-- Pure color math (`blend`) usable from any Lua runtime, plus a couple of
-- Neovim-only helpers (`unpack`, `reload`). `blend` is the one the packaging
-- layers lean on to derive shades from the base palette.
-- ----------------------------------------------------------------------------

local M = {}

--- Convert a "#RRGGBB" string to an {r, g, b} table.
---@param hex string
---@return integer[]
local function rgb(hex)
  hex = hex:lower()
  return {
    tonumber(hex:sub(2, 3), 16),
    tonumber(hex:sub(4, 5), 16),
    tonumber(hex:sub(6, 7), 16),
  }
end

--- Blend `foreground` over `background` by `alpha` (0..1) → "#RRGGBB".
--- alpha = 1 returns foreground, alpha = 0 returns background.
---@param foreground string
---@param background string
---@param alpha number
---@return string
function M.blend(foreground, background, alpha)
  local fg, bg = rgb(foreground), rgb(background)
  local function ch(i)
    local v = alpha * fg[i] + (1 - alpha) * bg[i]
    return math.floor(math.min(math.max(0, v), 255) + 0.5)
  end
  return string.format("#%02X%02X%02X", ch(1), ch(2), ch(3))
end

--- Flatten any `{ style = { ... } }` sub-table into the highlight spec itself,
--- so a group can carry style options (bold/italic/...) declaratively.
---@param groups table<string, table>
---@return table<string, table>
function M.unpack(groups)
  for _, hl in pairs(groups) do
    if type(hl.style) == "table" then
      for k, v in pairs(hl.style) do
        hl[k] = v
      end
      hl.style = nil
    end
  end
  return groups
end

--- Hot-reload the colorscheme: drop cached `lighter.*` modules (except config,
--- so user overrides survive) and re-apply. Bound to `:LighterReload`.
function M.reload()
  for name in pairs(package.loaded) do
    if name:match("^lighter") and name ~= "lighter.config" then
      package.loaded[name] = nil
    end
  end
  vim.cmd.colorscheme("lighter")
  vim.notify("lighter reloaded", vim.log.levels.INFO)
end

return M
