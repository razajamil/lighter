# lighter

A calm, **light** colorscheme for **Neovim** and **kitty** — based on the *glade*
variant of [koda.nvim](https://github.com/oskarnurm/koda.nvim), tuned for WCAG-AA
contrast on a `#f7f7f7` background.

One base palette drives both the editor and the terminal, so they always match.

---

## Install

### Neovim — LazyVim

Add `~/.config/nvim/lua/plugins/colorscheme.lua`:

```lua
return {
  { "razajamil/lighter", lazy = false, priority = 1000 },
  { "LazyVim/LazyVim", opts = { colorscheme = "lighter" } },
}
```

<sub>Plain **lazy.nvim** (not the distro): `{ "razajamil/lighter", lazy = false, priority = 1000, config = function() vim.cmd.colorscheme("lighter") end }`</sub>

### Neovim — vim.pack (built-in, Nvim 0.12+)

In your `init.lua`:

```lua
vim.pack.add({
  { src = "https://github.com/razajamil/lighter" },
})
vim.cmd.colorscheme("lighter")
```

### kitty

Add one line to `~/.config/kitty/kitty.conf` pointing at the generated conf, then
reload kitty (`ctrl+cmd+,` on macOS, `ctrl+shift+f5` on Linux) or restart:

```conf
include /path/to/lighter/extras/kitty/lighter.conf
```

Pick whichever path you already have on disk:

- **You installed the Neovim plugin** — reuse its copy:
  - LazyVim / lazy.nvim → `~/.local/share/nvim/lazy/lighter/extras/kitty/lighter.conf`
  - vim.pack → `~/.local/share/nvim/site/pack/core/opt/lighter/extras/kitty/lighter.conf`
- **kitty only** — clone it once:
  ```sh
  git clone https://github.com/razajamil/lighter ~/.config/kitty/lighter
  # then: include lighter/extras/kitty/lighter.conf
  ```
- Or download `lighter.conf` from the latest [release](https://github.com/razajamil/lighter/releases).

---

## Usage

- With either Neovim install above, the colorscheme loads automatically. To set it
  by hand: `:colorscheme lighter`.
- It's a light theme — it sets `background=light` on load.
- Options are optional. To pass any (transparency, per-role styles, color overrides):

  ```lua
  require("lighter").setup({ transparent = false })  -- see Reference → Options
  ```

## Pinning a version

Releases are semver **tags**; each ships the Neovim plugin and a matching
`extras/kitty/lighter.conf`. Pin to a tag for stability:

```lua
-- lazy.nvim / LazyVim
{ "razajamil/lighter", version = "*" }            -- latest stable tag

-- vim.pack
{ src = "https://github.com/razajamil/lighter", version = "v1.0.0" }
```

For kitty, a pinned tag means a pinned `lighter.conf` (use that tag's release asset
or `git checkout <tag>`).

## Make it your own

Everything is generated from one file — `lua/lighter/palette.lua`. Edit a hex there, then:

- **Neovim**: `:LighterReload` (no build step — Neovim reads the palette directly)
- **kitty**: `make build` to regenerate the conf, then `make reload` to live-apply

See **Reference → Architecture** for how a palette change propagates everywhere.

---

# Reference

## Architecture: one palette → many packages

```
Layer 1  palette.lua ............ base colors, the single source of truth (pure data)
Layer 2  groups/*.lua ........... Neovim highlight packaging (reads the palette)
         terminal.lua ........... shared 16-color ANSI map for all terminal emulators
Layer 3  build/targets/*.lua .... format the terminal map into each app's syntax
```

Neovim consumes the palette **live** (no build). Terminals can't read Lua, so their
configs are **generated** from the same palette and committed under `extras/`.

**The rule:** never hand-edit `extras/` — it's generated. Change `palette.lua`
(colors) or a packaging layer (`groups/*`, `terminal.lua`, `build/targets/*`), then
`make build`.

## Repository layout

```
lua/lighter/
  palette.lua        base colors (single source of truth)
  terminal.lua       shared terminal ANSI map
  config.lua         Neovim options (styles, transparency, overrides, hook)
  init.lua           Neovim entry: setup() / load() / :LighterReload
  utils.lua          color math (blend) + reload helper
  groups/            Neovim highlights: base · syntax · treesitter · lsp · gitsigns · typescript
colors/lighter.lua   `:colorscheme lighter`
after/queries/       TS/TSX treesitter overrides (auto-loaded by plugin managers)
build/
  generate.lua       build runner — regenerates app configs from the palette
  targets/kitty.lua  formats terminal.lua into a kitty color config
extras/kitty/lighter.conf   GENERATED — do not edit by hand
scripts/             dev helpers (wrapped by the Makefile)
```

## Options

`require("lighter").setup({ ... })` — all optional:

| option          | default          | meaning                                   |
| --------------- | ---------------- | ----------------------------------------- |
| `transparent`   | `false`          | use `none` backgrounds                    |
| `styles`        | `functions=bold`, `strings=italic` | per-role text styles (bold/italic/…)  |
| `colors`        | `{}`             | override base palette colors at runtime   |
| `on_highlights` | `fn(hl, colors)` | last-mile tweak/extend highlight groups   |

## Dev / build commands

```sh
make nvim                 # open Neovim with lighter active (FILE=path to preview a file)
make build                # regenerate extras/ from the palette
make kitty                # build + open a fresh kitty window using only the theme
make reload               # build + live-apply to running kitty windows*
```

<sub>* `make reload` needs kitty remote control: `allow_remote_control yes` in `kitty.conf`.</sub>

## Adding another terminal (ghostty, wezterm, fzf, …)

1. Write `build/targets/<app>.lua` returning `function(term, meta) -> string`. Read
   colors from `term.special` / `term.ansi` (the shared map) or
   `require("lighter.palette")` for raw named colors.
2. Register it in `build/generate.lua`'s `targets` list with an output path.
3. `make build`.

## TypeScript / TSX

`after/queries/{typescript,tsx}/` add a few language-scoped tweaks (de-emphasized
`import`/`export`, dark-red `const`/`let`/`return`, function-blue JSX element names,
the `type X =` declaration in the type color). They load automatically when the
plugin is on the runtimepath and you have the `typescript`/`tsx` treesitter parsers.

## Releases & packaging

Releases are semver tags. Each tag ships:

- the **Neovim plugin** (the repo itself — consumed via your plugin manager), and
- a regenerated **`extras/kitty/lighter.conf`** (committed, and attached to the GitHub
  release for non-plugin users).

Because the kitty conf is generated, it's kept in lockstep with the palette at
release time — so a given tag's editor and terminal colors always match.

## Accessibility

Colors target **WCAG AA** on the `#f7f7f7` background: ≥ 4.5:1 for code/body text,
≥ 3:1 for UI/borders. A few elements are intentionally low-contrast by design —
`NonText`/whitespace guides and the de-emphasized TS `import`/`export` — and the
terminal's ANSI "black" slot (`color0`) is a light neutral (the standard light-theme
inversion), meant as a background, not foreground text.

## Credits

Derived from the **glade** variant of [koda.nvim](https://github.com/oskarnurm/koda.nvim) by Oskar Nurm.
