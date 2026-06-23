-- ============================================================================
-- lighter — build runner
-- ============================================================================
-- Regenerates every application config from the base palette.
--   Run:  scripts/build.sh   (or `make build`)
--
-- Pure Lua — no Neovim APIs — so it runs under any `lua`/`luajit` (used in CI)
-- as well as Neovim (`nvim -l`). To add a target: write build/targets/<name>.lua
-- returning fn(term, meta) and add an entry to `targets` below.
-- ----------------------------------------------------------------------------

-- Resolve the repo root from this script's own path, so requires + output paths
-- work regardless of the current directory.
local function dirname(p)
  return p:match("^(.*)[/\\][^/\\]*$") or "."
end
local script = debug.getinfo(1, "S").source:sub(2) -- .../build/generate.lua
local root = dirname(dirname(script))               -- repo root

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
  { module = "build.targets.herdr", out = "/extras/herdr/lighter.toml" },
}

local function write(path, data)
  os.execute('mkdir -p "' .. dirname(path) .. '"')
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
