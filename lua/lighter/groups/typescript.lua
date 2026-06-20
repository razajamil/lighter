-- TypeScript / TSX-specific highlights.
--
-- These rely on the custom captures defined in `after/queries/{typescript,tsx}/
-- highlights.scm`, which re-tag specific keyword tokens so they can be colored
-- independently of the generic `@keyword` / `@keyword.import` groups (which are
-- shared across every language).
local M = {}

---@param c lighter.Palette
function M.get_hl(c)
  -- stylua: ignore
  return {
    -- import / export / from — de-emphasized, lighter than other keywords
    ["@keyword.lighter.import"] = { fg = c.faint },
    -- const / let / var declaration keywords — dark red
    ["@keyword.lighter.const"]  = { fg = c.red },
    -- JSX element names (built-in + components) — function blue
    ["@tag.lighter.element"]    = { fg = c.func },
    -- type-alias declaration name (`type Props = ...`) — the "type" color
    ["@type.lighter.declaration"] = { fg = c.type },
    -- return keyword — same dark red as const / let
    ["@keyword.lighter.return"] = { fg = c.red },
  }
end

return M
