local source = debug.getinfo(1, "S").source:sub(2)
local root = vim.fn.fnamemodify(source, ":p:h:h")
vim.opt.runtimepath:prepend(root)

local requested = os.getenv("SHEEPSKIN_TEST_VARIANT") or "auto"
local theme = require("sheepskin")

-- The colorscheme command must be usable without an explicit setup call.
vim.cmd.colorscheme("sheepskin")
assert(vim.fn.exists(":SheepskinToggle") == 2, "commands are not registered by colorscheme loading alone")

theme.setup({
  variant = requested,
  transparent = false,
  dim_inactive = true,
})
vim.cmd.colorscheme("sheepskin")

assert(vim.g.colors_name == "sheepskin", "colorscheme did not register itself")

local required_groups = {
  "Normal",
  "NormalFloat",
  "StatusLine",
  "Visual",
  "DiagnosticError",
  "Comment",
  "@keyword",
  "@string",
  "@lsp.type.function",
  "TelescopeSelection",
  "NeoTreeNormal",
  "NvimTreeNormal",
  "BufferLineBufferSelected",
  "GitSignsAdd",
  "SnacksPicker",
  "BlinkCmpMenu",
}

for _, name in ipairs(required_groups) do
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
  assert(next(hl) ~= nil, ("missing highlight group: %s"):format(name))
end

local dark = require("sheepskin.palette").get("dark")
local light = require("sheepskin.palette").get("light")
assert(dark.bg ~= light.bg, "dark and light palettes must differ")

theme.set_variant("dark")
local dark_normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
assert(dark_normal.bg == tonumber(dark.bg:sub(2), 16), "dark Normal background is incorrect")
local dark_lualine = require("lualine.themes.sheepskin")
assert(dark_lualine.normal.a.bg == dark.green, "dark lualine accent is incorrect")

theme.set_variant("light")
local light_normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
assert(light_normal.bg == tonumber(light.bg:sub(2), 16), "light Normal background is incorrect")
local light_lualine = require("lualine.themes.sheepskin")
assert(light_lualine.normal.a.bg == light.green, "light lualine accent is incorrect")
assert(vim.g.terminal_color_0 == light.bg, "terminal colors are not synchronized with the palette")

vim.cmd("SheepskinTransparent")
local transparent_normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
assert(transparent_normal.bg == nil, "transparent mode did not clear the window background")

vim.cmd("SheepskinTransparent")
local restored_normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
assert(restored_normal.bg == tonumber(light.bg:sub(2), 16), "opaque mode did not restore the background")

theme.setup({
  variant = requested,
  overrides = {
    Normal = { bg = "NONE" },
    SheepskinTestOverride = { fg = "syntax.string", bold = true },
  },
})
vim.cmd.colorscheme("sheepskin")

local normal_override = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
assert(normal_override.bg == nil, "override hook did not apply")

local active_variant = require("sheepskin.config").variant()
local active_palette = require("sheepskin.palette").get(active_variant)
local custom_override = vim.api.nvim_get_hl(0, { name = "SheepskinTestOverride", link = false })
assert(custom_override.fg == tonumber(active_palette.syntax.string:sub(2), 16), "semantic color names do not resolve")
assert(custom_override.bold == true, "override style was not applied")

assert(vim.fn.exists(":SheepskinDark") == 2, "SheepskinDark command is missing")
assert(vim.fn.exists(":SheepskinLight") == 2, "SheepskinLight command is missing")
assert(vim.fn.exists(":SheepskinToggle") == 2, "SheepskinToggle command is missing")

print(("sheepskin smoke test passed (%s, %s)"):format(vim.o.background, requested))
