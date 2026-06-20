-- Target: format the shared terminal package into a kitty color config.
-- See https://sw.kovidgoyal.net/kitty/conf/#color-scheme
---@param term table  the lighter.terminal table (special + ansi)
---@param meta table  { name, author, upstream }
---@return string
return function(term, meta)
  local out = {}
  local function line(s) out[#out + 1] = s or "" end
  local function kv(key, val) out[#out + 1] = string.format("%-24s%s", key, val) end

  local s = term.special

  line("# vim:ft=kitty")
  line("")
  line("## name:     " .. meta.name)
  line("## author:   " .. meta.author)
  line("## upstream: " .. meta.upstream)
  line("")
  line("# GENERATED from lua/lighter/palette.lua — do not edit by hand.")
  line("# Edit the palette, then run `make build`.")
  line("")

  line("# Basic colors")
  kv("foreground", s.foreground)
  kv("background", s.background)
  kv("selection_foreground", s.selection_foreground)
  kv("selection_background", s.selection_background)
  line("")

  line("# Cursor")
  kv("cursor", s.cursor)
  kv("cursor_text_color", s.cursor_text)
  line("")

  line("# URLs")
  kv("url_color", s.url)
  line("")

  line("# Window / split borders")
  kv("active_border_color", s.border_active)
  kv("inactive_border_color", s.border_inactive)
  kv("bell_border_color", s.border_bell)
  line("")

  line("# Tab bar")
  kv("active_tab_foreground", s.tab_active_fg)
  kv("active_tab_background", s.tab_active_bg)
  kv("inactive_tab_foreground", s.tab_inactive_fg)
  kv("inactive_tab_background", s.tab_inactive_bg)
  kv("tab_bar_background", s.tab_bar_bg)
  line("")

  line("# The 16 terminal colors")
  for i = 0, 15 do
    kv("color" .. i, term.ansi[i])
  end
  line("")

  return table.concat(out, "\n")
end
