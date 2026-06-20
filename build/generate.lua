-- ============================================================================
-- lighter — build runner
-- ============================================================================
-- Regenerates every application config from the base palette.
--   Run:  nvim --headless -l build/generate.lua      (or `make build`)
--
-- Neovim is just used as a convenient Lua runtime here — no plugins, no config.
-- To add a target: write build/targets/<name>.lua returning fn(term, meta) and
-- add an entry to `targets` below.
-- ----------------------------------------------------------------------------

-- Resolve the repo root from this script's own location, then make both the
-- `lighter.*` modules and `build.targets.*` requireable regardless of cwd.
local script = debug.getinfo(1, "S").source:sub(2)
local root = vim.fn.fnamemodify(script, ":h:h")
package.path = table.concat({
  root .. "/lua/?.lua",
  root .. "/lua/?/init.lua",
  root .. "/?.lua",
  package.path,
}, ";")

local meta = {
  name = "Lighter (Glade)",
  author = "Raza Jamil",
  upstream = "based on koda.nvim — glade variant",
}

local term = require("lighter.terminal")

local targets = {
  { module = "build.targets.kitty", out = "/extras/kitty/lighter.conf" },
}

local function write(path, data)
  vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
  local f = assert(io.open(path, "w"))
  f:write(data)
  f:close()
end

for _, t in ipairs(targets) do
  local render = require(t.module)
  local path = root .. t.out
  write(path, render(term, meta))
  print("  generated " .. path)
end

print("lighter: build complete.")
