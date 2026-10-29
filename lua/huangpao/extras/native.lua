local M = {}

-- Stable serialization keeps exports reproducible across supported Neovim versions.
local function keys(value)
  local result = vim.tbl_keys(value)
  table.sort(result)
  return result
end

local function json(value, depth)
  if type(value) ~= "table" then
    return vim.fn.json_encode(value)
  end
  depth = depth or 0
  if next(value) == nil then
    return "{}"
  end
  local list = (vim.islist or vim.tbl_islist)(value)
  local lines = {}
  for _, key in ipairs(keys(value)) do
    lines[#lines + 1] = string.rep("  ", depth + 1)
      .. (list and "" or vim.fn.json_encode(key) .. ": ")
      .. json(value[key], depth + 1)
  end
  return (list and "[" or "{")
    .. "\n"
    .. table.concat(lines, ",\n")
    .. "\n"
    .. string.rep("  ", depth)
    .. (list and "]" or "}")
end

local function xml_escape(value)
  return value:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;")
end

local function xml(value, depth)
  local indent = string.rep("  ", depth)
  if type(value) == "string" then
    return indent .. "<string>" .. xml_escape(value) .. "</string>\n"
  end
  local list = #value > 0
  local tag = list and "array" or "dict"
  local lines = { indent .. "<" .. tag .. ">\n" }
  local order = list and {} or keys(value)
  if list then
    for index = 1, #value do
      order[index] = index
    end
  end
  for _, key in ipairs(order) do
    if not list then
      lines[#lines + 1] = indent .. "  <key>" .. xml_escape(key) .. "</key>\n"
    end
    lines[#lines + 1] = xml(value[key], depth + 1)
  end
  lines[#lines + 1] = indent .. "</" .. tag .. ">\n"
  return table.concat(lines)
end

local function plist(value)
  return '<?xml version="1.0" encoding="UTF-8"?>\n'
    .. '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">\n'
    .. '<plist version="1.0">\n'
    .. xml(value, 0)
    .. "</plist>\n"
end

local function bat(p)
  local s = p.syntax
  local settings = {
    {
      settings = {
        background = p.bg,
        foreground = p.text,
        caret = p.cursor,
        selection = p.bg_selected,
        lineHighlight = p.bg_highlight,
        invisibles = p.text_faint,
        gutter = p.bg,
        gutterForeground = p.text_dim,
      },
    },
  }
  for _, item in ipairs({
    { "comment", s.comment, "italic" },
    { "keyword.control, keyword.other, storage", s.keyword },
    { "keyword.operator", s.operator },
    { "string", s.string },
    { "constant.language, constant.other, variable.other.constant", s.constant },
    { "constant.numeric", s.number },
    { "constant.character.escape", s.escape },
    { "entity.name.function, entity.name.function.method", s.func, "bold" },
    { "support.function", s.special, "bold" },
    { "variable", s.variable },
    { "variable.parameter", s.parameter },
    { "entity.name.type, entity.name.class, support.type, support.class, storage.type", s.type },
    { "variable.other.property, variable.other.member", s.property },
    { "entity.other.attribute-name", s.attribute },
    { "entity.name.tag", s.tag },
    { "punctuation", s.punctuation },
    { "markup.heading", p.yellow, "bold" },
    { "markup.bold", p.text_strong, "bold" },
    { "markup.italic", p.text, "italic" },
    { "markup.underline.link", p.blue, "underline" },
    { "markup.raw", s.string },
    { "markup.inserted", p.green, nil, p.diff_add },
    { "markup.deleted", p.red, nil, p.diff_delete },
    { "markup.changed", p.yellow, nil, p.diff_change },
    { "invalid", p.red, nil, p.diagnostic_error_bg },
  }) do
    settings[#settings + 1] = {
      scope = item[1],
      settings = { foreground = item[2], fontStyle = item[3], background = item[4] },
    }
  end
  return plist({ name = "HuangPao", semanticClass = "theme.light.huangpao", settings = settings })
end

local function delta(p)
  local options = {
    { "light", "true" },
    { "dark", "false" },
    { "syntax-theme", "HuangPao" },
    { "minus-style", ('syntax "%s"'):format(p.diff_delete) },
    { "minus-emph-style", ('"%s" bold "%s"'):format(p.text_strong, p.diff_delete) },
    { "plus-style", ('syntax "%s"'):format(p.diff_add) },
    { "plus-emph-style", ('"%s" bold "%s"'):format(p.text_strong, p.diff_text) },
    { "zero-style", ('syntax "%s"'):format(p.bg) },
    { "file-style", ('bold "%s"'):format(p.blue) },
    { "file-decoration-style", ('"%s" ul'):format(p.border) },
    { "hunk-header-style", "syntax file line-number" },
    { "hunk-header-decoration-style", ('"%s" box'):format(p.border) },
    { "line-numbers-left-style", ('"%s" "%s"'):format(p.text_dim, p.bg) },
    { "line-numbers-right-style", ('"%s" "%s"'):format(p.text_dim, p.bg) },
    { "line-numbers-zero-style", ('"%s" "%s"'):format(p.text_dim, p.bg) },
    { "line-numbers-minus-style", ('"%s" "%s"'):format(p.red, p.diff_delete) },
    { "line-numbers-plus-style", ('"%s" "%s"'):format(p.green, p.diff_add) },
  }
  local lines = { '[delta "huangpao"]\n' }
  for _, item in ipairs(options) do
    lines[#lines + 1] = ("    %s = %s\n"):format(item[1], item[2])
  end
  return table.concat(lines)
end

local function alfred(p)
  local function text(color, size, selected, font)
    return { color = color .. "FF", colorSelected = selected .. "FF", font = font or "System", size = size }
  end
  return {
    alfredtheme = {
      credit = "HuangPao.nvim contributors",
      name = "HuangPao Light Large",
      result = {
        backgroundSelected = p.bg_selected .. "FF",
        iconPaddingHorizontal = 7,
        iconSize = 40,
        paddingVertical = 4,
        roundness = 8,
        shortcut = text(p.orange, 18, p.text_strong),
        subtext = text(p.text_muted, 14, p.text),
        text = text(p.text, 18, p.text_strong),
        textSpacing = 5,
      },
      scrollbar = { color = p.border .. "FF", thickness = 2 },
      search = {
        background = p.surface .. "FF",
        backgroundSelected = p.bg_selected .. "FF",
        paddingHorizontal = 7,
        paddingVertical = 5,
        roundness = 8,
        spacing = 9,
        text = text(p.text_strong, 36, p.text_strong, "System Light"),
      },
      separator = { color = p.border .. "FF", thickness = 1 },
      visualEffectMode = 1,
      window = {
        blur = 0,
        borderColor = p.border .. "FF",
        borderPadding = 0,
        color = p.bg .. "FF",
        paddingHorizontal = 9,
        paddingVertical = 9,
        roundness = 15,
        width = 760,
      },
    },
  }
end

local function slides(p)
  local s = p.syntax
  local function color(fg, attrs)
    return vim.tbl_extend("force", { color = fg }, attrs or {})
  end
  local chroma = {
    text = color(p.text),
    error = color(p.red, { background_color = p.diagnostic_error_bg }),
    comment = color(s.comment, { italic = true }),
    comment_preproc = color(s.special),
    keyword = color(s.keyword),
    keyword_reserved = color(s.keyword),
    keyword_namespace = color(s.namespace),
    keyword_type = color(s.type),
    operator = color(s.operator),
    punctuation = color(s.punctuation),
    name = color(s.variable),
    name_builtin = color(s.special, { bold = true }),
    name_tag = color(s.tag),
    name_attribute = color(s.attribute),
    name_class = color(s.type),
    name_constant = color(s.constant),
    name_decorator = color(s.special),
    name_exception = color(p.red),
    name_function = color(s.func, { bold = true }),
    name_other = color(s.variable),
    literal = color(s.constant),
    literal_number = color(s.number),
    literal_date = color(s.number),
    literal_string = color(s.string),
    literal_string_doc = color(s.comment, { italic = true }),
    literal_string_escape = color(s.escape),
    generic_deleted = color(p.red, { background_color = p.diff_delete }),
    generic_inserted = color(p.green, { background_color = p.diff_add }),
    generic_emph = { italic = true },
    generic_strong = color(p.text_strong, { bold = true }),
    generic_subheading = color(p.orange, { bold = true }),
    background = color(p.text, { background_color = p.bg }),
  }
  return {
    document = color(
      p.text,
      { background_color = p.bg, block_prefix = "\n\n\n\n\n", block_suffix = "\n", margin = 33 }
    ),
    block_quote = color(p.text_muted, { indent = 1, indent_token = "│ " }),
    paragraph = {},
    list = { level_indent = 4 },
    heading = color(p.orange, { block_suffix = "\n\n", bold = true }),
    h1 = color(p.text_strong, { prefix = "██ ", suffix = " ", bold = true }),
    h2 = color(p.orange, { prefix = "▓▓▓ " }),
    h3 = color(p.green, { prefix = "▒▒▒▒ " }),
    h4 = color(p.blue, { prefix = "░░░░░ " }),
    h5 = color(p.purple),
    h6 = color(p.text_muted),
    text = {},
    strikethrough = { crossed_out = true },
    emph = { italic = true },
    strong = color(p.text_strong, { bold = true }),
    hr = color(p.border, { format = "\n--------\n" }),
    item = { block_prefix = "• " },
    enumeration = { block_prefix = ". " },
    task = { ticked = "[✓] ", unticked = "[ ] " },
    link = color(p.blue, { underline = true }),
    link_text = color(p.aqua, { bold = true }),
    image = color(p.purple, { underline = true }),
    image_text = color(p.text_dim, { format = "Image: {{.text}} →" }),
    code = color(p.orange, { prefix = "", suffix = "", background_color = p.bg_alt }),
    code_block = color(p.text, { background_color = p.bg, margin = 0, chroma = chroma }),
    table = { center_separator = "┼", column_separator = "│", row_separator = "─" },
    definition_list = {},
    definition_term = color(p.orange, { bold = true }),
    definition_description = { block_prefix = "\n🠶 " },
    html_block = {},
    html_span = {},
  }
end

function M.get(p)
  -- Preserve the installed Alfred appearance's persistent identity.
  local alfred_id = "theme.custom.1718079A-1C3F-44DA-A83C-BC93AA51C9FA"
  return {
    ["extras/palette.json"] = json(p) .. "\n",
    ["extras/bat/HuangPao.tmTheme"] = bat(p),
    ["extras/delta/huangpao.gitconfig"] = delta(p),
    ["extras/alfred/HuangPao Light Large.alfredappearance"] = json(alfred(p)) .. "\n",
    ["extras/alfred/huangpao.plist"] = plist({ lightthemeuid = alfred_id, darkthemeuid = alfred_id }),
    ["extras/slides/huangpao_theme.json"] = json(slides(p)) .. "\n",
  }
end

return M
