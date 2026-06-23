-- yanky.nvim — the yank/put flash.
--
-- yanky links YankyYanked/YankyPut to `Search` by default, which in this theme
-- is the selection color (`line`) — so a yank looks identical to a normal
-- selection. Give them a solid accent block so a yank/put clearly flashes.
local M = {}

---@param c lighter.Palette
function M.get_hl(c)
  -- stylua: ignore
  return {
    YankyYanked = { fg = c.bg, bg = c.emphasis, bold = true },
    YankyPut    = { fg = c.bg, bg = c.emphasis, bold = true },
  }
end

return M
