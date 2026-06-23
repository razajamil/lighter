-- Target: herdr theme overrides ([theme.custom]).
--
-- herdr (https://github.com/ogulcancelik/herdr) uses `name = "terminal"` to
-- inherit the live terminal palette (i.e. lighter via kitty). A few UI tokens
-- that the terminal theme derives don't land where we want, so this block
-- overrides them. herdr has no config `include`, so it's copied by hand into
-- ~/.config/herdr/config.toml.
--
-- Token roles were verified against herdr's source, not guessed.
---@param _term table  unused (herdr maps named palette colors, not ANSI slots)
---@param meta table   { name, author, upstream }
---@return string
return function(_term, meta)
  local p = require("lighter.palette")
  local out = {}
  local function line(s) out[#out + 1] = s or "" end

  line("# vim:ft=toml")
  line("## " .. meta.name .. " — herdr theme overrides")
  line("## " .. meta.upstream)
  line("#")
  line("# GENERATED from lua/lighter/palette.lua — do not edit by hand.")
  line("# herdr has no config `include`: copy the [theme.custom] block below into")
  line('# ~/.config/herdr/config.toml. Requires the base theme `[theme] name = "terminal"`')
  line("# so herdr inherits the lighter palette from your terminal.")
  line("#")
  line("# Token roles (verified against herdr source):")
  line("#   surface_dim — active/selected workspace row background  (src/ui/sidebar.rs)")
  line("#   accent      — selected tab background + nav accents      (src/ui/tabs.rs)")
  line("#                 NB: the selected tab's fg is panel_bg (~white); herdr has")
  line("#                 no tab-only foreground token.")
  line("")
  line("[theme.custom]")
  line(string.format('surface_dim = "%s"', p.dim))
  line(string.format('accent      = "%s"', p.pink))
  line("")

  return table.concat(out, "\n")
end
