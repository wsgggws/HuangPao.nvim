# Agent guide

sheepskin.nvim is a low-fatigue Neovim colorscheme. Its visual identity is a
warm dark-yellow light theme and a warm olive dark theme. Keep changes quiet,
readable, and consistent across the core editor and supported plugins.

## Layout

- `colors/sheepskin.lua`: colorscheme entry point.
- `lua/sheepskin/init.lua`: public API, commands, and highlight application.
- `lua/sheepskin/config.lua`: option defaults and validation.
- `lua/sheepskin/palette.lua`: the only source of concrete color values.
- `lua/sheepskin/groups/`: editor, Tree-sitter, LSP, and plugin groups.
- `lua/lualine/themes/sheepskin.lua`: native lualine theme.
- `tests/smoke.lua`: headless integration test.
- `.github/workflows/`: CI, release, and dependency automation.
- `assets/`: real UI screenshots used by the README.

## Rules

1. Change colors only in `palette.lua`. Group modules consume semantic palette
   values and never hard-code hex colors.
2. Keep group builders declarative. They receive palette/options and return a
   highlight table; they do not execute editor commands.
3. The colorscheme must load with Neovim alone. Define plugin groups without
   requiring those plugins.
4. Apply user `overrides` last. Applying them before built-in groups silently
   breaks the public API.
5. Preserve Neovim 0.9 compatibility. Do not introduce plugin dependencies into
   the runtime path.
6. Keep comments subdued but readable. Use hue, weight, and contrast sparingly,
   and avoid adding noisy borders or bright backgrounds.
7. Update `README.md` when setup, options, commands, or supported extensions
   change. Keep it concise and aligned with actual behavior.

## Validation

Run all checks before committing:

```sh
stylua --check .
make test
make test-dark
make test-light
```

Palette changes should also be checked against the screenshot source or a real
Neovim session, including normal text, comments, diagnostics, floats, selection,
diff, lualine, Snacks, and tree views.

## Public API

Keep these entry points stable:

```lua
require("sheepskin").setup(opts)
require("sheepskin").load()
require("sheepskin").set_variant("dark" | "light")
require("sheepskin").toggle()
require("sheepskin").get_palette()
```

The primary user integration remains:

```vim
:colorscheme sheepskin
```

## Release

CI runs on pushes, pull requests, and manual dispatch. A `vX.Y.Z` tag triggers
the release workflow. Do not commit generated plugin-manager state or local
configuration.
