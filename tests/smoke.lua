local source = debug.getinfo(1, "S").source:sub(2)
local root = vim.fn.fnamemodify(source, ":p:h:h")
vim.opt.runtimepath:prepend(root)

local theme = require("huangpao")

-- Loading the colorscheme without setup must work and always select light.
vim.o.background = "dark"
vim.cmd.colorscheme("huangpao")
assert(vim.g.colors_name == "huangpao", "colorscheme did not register itself")
assert(vim.o.background == "light", "huangpao must force the light background")
assert(vim.fn.exists(":HuangPaoTransparent") == 2, "HuangPaoTransparent command is missing")
assert(vim.fn.exists(":HuangPaoDark") == 0, "HuangPaoDark must not exist")
assert(vim.fn.exists(":HuangPaoLight") == 0, "HuangPaoLight must not exist")
assert(vim.fn.exists(":HuangPaoToggle") == 0, "HuangPaoToggle must not exist")
assert(theme.set_variant == nil, "set_variant must not be part of the public API")
assert(theme.toggle == nil, "toggle must not be part of the public API")

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

local palette = require("huangpao.palette").get()
local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
assert(normal.bg == tonumber(palette.bg:sub(2), 16), "Normal background is incorrect")

-- Semantic categories must remain distinct after Tree-sitter/LSP resolution.
local semantic_groups = {
  variable = { "Identifier", "@variable", "@lsp.type.variable", "TelescopeResultsVariable" },
  parameter = { "@variable.parameter", "@lsp.type.parameter" },
  property = { "@variable.member", "@lsp.type.property", "TelescopeResultsField" },
  number = { "Number", "@number", "@lsp.type.number", "TelescopeResultsNumber" },
  type = { "Type", "@type", "@lsp.type.type" },
  comment = { "Comment", "@comment", "@lsp.type.comment" },
  func = { "Function", "@function", "@function.call", "@lsp.type.function" },
  method = { "@function.method", "@function.method.call", "@method", "@method.call", "@lsp.type.method" },
  string = { "String", "@string", "@string.documentation", "@lsp.type.string", "TelescopeResultsString" },
  operator = { "Operator", "@operator", "@lsp.type.operator", "TelescopeResultsOperator" },
  keyword = { "Keyword", "@keyword", "@keyword.operator", "@lsp.type.keyword" },
  constant = { "Constant", "@constant", "@lsp.type.enumMember", "@lsp.typemod.variable.readonly" },
  punctuation = { "Delimiter", "@punctuation", "@punctuation.bracket", "@punctuation.delimiter" },
}
for category, names in pairs(semantic_groups) do
  for _, name in ipairs(names) do
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    assert(hl.fg == tonumber(palette.syntax[category]:sub(2), 16), name .. " has inconsistent syntax coloring")
  end
end
assert(palette.syntax.variable ~= palette.text, "variables must stand apart from normal UI text")
assert(palette.syntax.variable ~= palette.syntax.parameter, "parameters must stand apart from variables")
assert(palette.syntax.variable ~= palette.syntax.property, "properties must stand apart from variables")
assert(palette.syntax.number ~= palette.syntax.boolean, "numbers must stand apart from booleans")
assert(palette.syntax.type ~= palette.syntax.string, "types must stand apart from strings")
local comment = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
assert(comment.italic == true, "comments must retain their subdued italic style")

-- Callable names must stay distinct from fields, including semantic-token overrides.
local callables = {
  "Function",
  "@function",
  "@function.call",
  "@function.method",
  "@function.method.call",
  "@method",
  "@method.call",
  "@function.builtin",
  "@lsp.type.function",
  "@lsp.type.method",
  "@lsp.typemod.function.defaultLibrary",
  "@lsp.typemod.method.defaultLibrary",
}
for _, name in ipairs(callables) do
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
  assert(hl.bold == true, name .. " must emphasize callable names")
end
assert(palette.syntax.method ~= palette.syntax.property, "methods must stand apart from fields")
assert(palette.syntax.operator ~= palette.syntax.punctuation, "operators must stand apart from punctuation")
assert(palette.syntax.punctuation ~= palette.syntax.comment, "punctuation must stand apart from comments")

-- Executable code must stand apart from subdued comments on the paper background.
local function luminance(hex)
  local channels = {}
  for channel in hex:gmatch("%x%x") do
    local value = tonumber(channel, 16) / 255
    channels[#channels + 1] = value <= 0.04045 and value / 12.92 or ((value + 0.055) / 1.055) ^ 2.4
  end
  return channels[1] * 0.2126 + channels[2] * 0.7152 + channels[3] * 0.0722
end

local function contrast(fg, bg)
  local a, b = luminance(fg), luminance(bg)
  return (math.max(a, b) + 0.05) / (math.min(a, b) + 0.05)
end

assert(contrast(palette.terminal.selection_fg, palette.terminal.selection_bg) >= 4.5, "terminal selected text contrast")
assert(contrast(palette.terminal.selection_bg, palette.bg) >= 3, "terminal selection must stand out from yellow paper")
assert(palette.terminal.preview_bg ~= palette.terminal.sidebar_bg, "fzf preview must have a distinct sidebar")
assert(palette.terminal.preview_bg == palette.bg, "fzf preview retains the source theme's paper background")
local native_themes = require("huangpao.extras").get(palette)
for path, expected in pairs(native_themes) do
  local file = assert(io.open(root .. "/" .. path, "rb"), "missing native theme: " .. path)
  local content = file:read("*a")
  file:close()
  assert(content == expected, "outdated native theme: " .. path)
end

for _, category in ipairs({
  "variable",
  "parameter",
  "property",
  "func",
  "method",
  "keyword",
  "string",
  "number",
  "type",
  "constant",
  "operator",
  "punctuation",
}) do
  assert(
    contrast(palette.syntax[category], palette.bg) > contrast(palette.syntax.comment, palette.bg),
    category .. " must remain more prominent than comments"
  )
end

local lualine = require("lualine.themes.huangpao")
assert(lualine.normal.a.bg == palette.green, "lualine accent is incorrect")
assert(vim.g.terminal_color_0 == palette.bg, "terminal colors are not synchronized")

vim.cmd("HuangPaoTransparent")
local transparent_normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
assert(transparent_normal.bg == nil, "transparent mode did not clear the background")

vim.cmd("HuangPaoTransparent")
local restored_normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
assert(restored_normal.bg == tonumber(palette.bg:sub(2), 16), "opaque mode did not restore the background")

theme.setup({ styles = { functions = { bold = false } } })
vim.cmd.colorscheme("huangpao")
for _, name in ipairs(callables) do
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
  assert(not hl.bold, name .. " must respect styles.functions.bold = false")
end

theme.setup({
  overrides = {
    Normal = { bg = "NONE" },
    HuangPaoTestOverride = { fg = "syntax.string", bold = true },
  },
})
vim.cmd.colorscheme("huangpao")

local normal_override = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
assert(normal_override.bg == nil, "override hook did not apply")

local custom_override = vim.api.nvim_get_hl(0, { name = "HuangPaoTestOverride", link = false })
assert(custom_override.fg == tonumber(palette.syntax.string:sub(2), 16), "semantic color names do not resolve")
assert(custom_override.bold == true, "override style was not applied")

print("huangpao smoke test passed (light)")
