-- Target: lazygit theme (gui.theme).
--
-- lazygit (https://github.com/jesseduffield/lazygit) is themed via the
-- `gui.theme` block in its config.yml. It reads named ANSI colors *or* hex
-- strings; we emit hex straight from the palette so it matches the editor and
-- terminal exactly. lazygit has no config `include`, so the block is copied (or
-- written) into the user's config.yml — find its dir with
-- `lazygit --print-config-dir` (macOS: ~/Library/Application Support/lazygit,
-- Linux: ~/.config/lazygit).
--
-- Hex values are quoted because a bare `#hex` is a YAML comment. Style words
-- (e.g. `bold`) are left unquoted. Theme keys verified against lazygit's
-- docs/Config.md.
---@param _term table  unused (lazygit maps named palette colors, not ANSI slots)
---@param meta table   { name, author, upstream }
---@return string
return function(_term, meta)
  local p = require("lighter.palette")
  local out = {}
  local function line(s) out[#out + 1] = s or "" end

  -- Emit `    key:` followed by one `      - <value>` per entry.
  local function color(key, ...)
    line("    " .. key .. ":")
    for _, v in ipairs({ ... }) do
      line("      - " .. v)
    end
  end
  -- Quote a hex so YAML doesn't treat `#` as a comment.
  local function q(hex) return string.format("%q", hex) end

  line("# vim:ft=yaml")
  line("## " .. meta.name .. " — lazygit theme")
  line("## " .. meta.upstream)
  line("#")
  line("# GENERATED from lua/lighter/palette.lua — do not edit by hand.")
  line("# Edit the palette, then run `make build`.")
  line("#")
  line("# lazygit has no config `include`: copy the gui.theme block below into your")
  line("# lazygit config.yml (`lazygit --print-config-dir` locates it).")
  line("#")
  line("# Color roles (keys verified against lazygit docs/Config.md):")
  line("#   activeBorderColor      — focused window border  (accent blue, like kitty)")
  line("#   selectedLineBgColor    — selected line in the focused panel")
  line("#   cherryPickedCommit*    — commits copied for cherry-pick")
  line("#   markedBaseCommit*      — base commit marked for rebase")
  line("#   unstagedChangesColor   — files with unstaged changes (git delete red)")
  line("")
  line("gui:")
  line("  theme:")
  color("activeBorderColor", q(p.emphasis), "bold")           -- focused window border
  color("inactiveBorderColor", q(p.border))                   -- non-focused borders
  color("searchingActiveBorderColor", q(p.highlight), "bold") -- border while searching
  color("optionsTextColor", q(p.emphasis))                    -- keybinding help bar
  color("selectedLineBgColor", q(p.dim))                      -- focused selection bg
  color("inactiveViewSelectedLineBgColor", q(p.line))         -- unfocused selection bg
  color("cherryPickedCommitFgColor", q(p.bg))                 -- copied commit text
  color("cherryPickedCommitBgColor", q(p.cyan))               -- copied commit highlight
  color("markedBaseCommitFgColor", q(p.bg))                   -- rebase base commit text
  color("markedBaseCommitBgColor", q(p.warning))              -- rebase base commit highlight
  color("unstagedChangesColor", q(p.danger))                  -- unstaged changes (red)
  color("defaultFgColor", q(p.fg))                            -- default text
  line("")

  return table.concat(out, "\n")
end
