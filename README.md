# lighter

A personal Neovim + terminal theme, light and calm, based on the **glade** variant
of [koda.nvim](https://github.com/oskarnurm/koda.nvim).

The design is **one set of base colors → many application packages**. Change a
color once and rebuild; every target (Neovim, kitty, …) picks it up.

## Layout

```
lua/lighter/
  palette.lua        LAYER 1 — base colors (the single source of truth). Pure data.
  terminal.lua       LAYER 2 — shared terminal ANSI map (used by every emulator target)
  groups/            LAYER 2 — Neovim highlight packaging (consumes palette directly)
    base · syntax · treesitter · lsp · gitsigns
  config.lua         Neovim setup options (styles, transparency, overrides, hook)
  init.lua           Neovim entry point: setup() / load() / :LighterReload
  utils.lua          color math (blend) + reload helper
colors/lighter.lua   `:colorscheme lighter`
build/
  generate.lua       build runner — regenerates app configs from the palette
  targets/kitty.lua  formats terminal.lua into a kitty color config
extras/kitty/lighter.conf   GENERATED — do not edit by hand
scripts/             dev helpers (see Makefile)
```

**The rule:** never hand-edit anything in `extras/`. Edit `palette.lua` (colors)
or a packaging layer (`groups/*`, `terminal.lua`, `build/targets/*`), then rebuild.

## Editing the theme

1. Open `lua/lighter/palette.lua` and change hex values. Keep the color *names*
   stable — every package refers to colors by name.
2. See it in Neovim and kitty (below).

### Neovim

```sh
make nvim                 # opens palette.lua with lighter active
make nvim FILE=some.ts    # open a specific file to preview real code
```

After editing colors, run `:LighterReload` inside nvim to re-apply without restarting.

Neovim reads the palette directly — **no build step** is needed for nvim changes.

### kitty

kitty can't read Lua, so its config is generated from the palette:

```sh
make build      # regenerate extras/kitty/lighter.conf from the palette
make kitty      # build + open a fresh kitty window using only the theme
make reload     # build + live-apply to running kitty windows*
```

\* `make reload` needs kitty remote control: add `allow_remote_control yes` to
your `kitty.conf` (or launch with `kitty -o allow_remote_control=yes`).

## Installing for real use

**Neovim** — point your plugin manager at this directory, e.g. with lazy.nvim:

```lua
{ dir = "/Users/raza.jamil/dev/lighter", lazy = false, priority = 1000,
  config = function()
    require("lighter").setup({})   -- optional; see config.lua for options
    vim.cmd.colorscheme("lighter")
  end }
```

**kitty** — `include` the generated file in your `~/.config/kitty/kitty.conf`:

```conf
include /Users/raza.jamil/dev/lighter/extras/kitty/lighter.conf
```

## Adding another application (e.g. ghostty, wezterm, fzf)

1. Write `build/targets/<app>.lua` returning `function(term, meta) -> string`.
   Read colors from `term.special` and `term.ansi` (the shared terminal map),
   or `require("lighter.palette")` for raw named colors.
2. Register it in `build/generate.lua`'s `targets` list with an output path.
3. `make build`.

## Setup options (Neovim)

`require("lighter").setup({ ... })` — all optional:

| option          | default              | meaning                                        |
| --------------- | -------------------- | ---------------------------------------------- |
| `transparent`   | `false`              | use `none` backgrounds                         |
| `styles`        | `functions=bold`     | per-role text styles (bold/italic/…)           |
| `colors`        | `{}`                 | override base palette colors at runtime        |
| `on_highlights` | `fn(hl, colors)`     | last-mile tweak/extend highlight groups        |
```
