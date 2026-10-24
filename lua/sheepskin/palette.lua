local M = {}

local raw = {
  dark = {
    bg = "#302b18",
    bg_inactive = "#2a2515",
    bg_alt = "#39321c",
    bg_highlight = "#443b22",
    bg_selected = "#52472a",
    bg_visual = "#4b5237",
    surface = "#39321c",
    surface_alt = "#463c22",
    border = "#665b38",
    border_subtle = "#4d4328",
    text = "#ddd2b8",
    text_strong = "#ede1c5",
    text_muted = "#b3a88e",
    text_dim = "#928770",
    text_faint = "#746c58",
    red = "#ce7c70",
    orange = "#d89d68",
    yellow = "#d5b66d",
    green = "#a8b97d",
    aqua = "#8db3a1",
    blue = "#8eabc1",
    purple = "#bd95b2",
    gray = "#929083",
    cursor = "#dfb978",
    search = "#786338",
    match = "#5f5230",
    diff_add = "#34432c",
    diff_delete = "#4a3027",
    diff_change = "#31414a",
    diff_text = "#43583b",
    diagnostic_error_bg = "#4a3027",
    diagnostic_warn_bg = "#4b4025",
    diagnostic_info_bg = "#31404a",
    diagnostic_hint_bg = "#344334",
  },
  light = {
    bg = "#d9bd7a",
    bg_inactive = "#d6ba77",
    bg_alt = "#d1b46f",
    bg_highlight = "#c9aa63",
    bg_selected = "#bd9851",
    bg_visual = "#c8cd92",
    surface = "#dfc486",
    surface_alt = "#cfae69",
    border = "#a88d58",
    border_subtle = "#bea15f",
    text = "#342f23",
    text_strong = "#252219",
    text_muted = "#504a37",
    text_dim = "#615a43",
    text_faint = "#766b4b",
    comment = "#706c62",
    red = "#7d2925",
    orange = "#683b13",
    yellow = "#563e0a",
    green = "#315023",
    aqua = "#1f5140",
    blue = "#244b66",
    purple = "#613457",
    gray = "#4e4937",
    cursor = "#683b13",
    search = "#b28f48",
    match = "#c2a45f",
    diff_add = "#b8c68f",
    diff_delete = "#d0a899",
    diff_change = "#b3c5c8",
    diff_text = "#a2ba82",
    diagnostic_error_bg = "#d0a899",
    diagnostic_warn_bg = "#cbb26d",
    diagnostic_info_bg = "#b3c5c8",
    diagnostic_hint_bg = "#b6c8a0",
  },
}

local function syntax(colors)
  return {
    comment = colors.comment or colors.text_muted,
    keyword = colors.red,
    conditional = colors.red,
    repeat_ = colors.red,
    exception = colors.red,
    operator = colors.orange,
    string = colors.yellow,
    escape = colors.orange,
    regexp = colors.yellow,
    number = colors.purple,
    boolean = colors.purple,
    constant = colors.orange,
    func = colors.green,
    method = colors.aqua,
    variable = colors.text,
    parameter = colors.blue,
    property = colors.aqua,
    type = colors.yellow,
    namespace = colors.aqua,
    tag = colors.blue,
    attribute = colors.yellow,
    label = colors.orange,
    punctuation = colors.text_dim,
    special = colors.orange,
    todo = colors.yellow,
  }
end

for _, colors in pairs(raw) do
  colors.syntax = syntax(colors)
end

function M.get(variant)
  local colors = raw[variant]
  assert(colors, ('sheepskin: unknown palette variant "%s"'):format(tostring(variant)))
  return colors
end

function M.resolve(colors, value)
  if type(value) ~= "string" then
    return value
  end

  if value == "NONE" or value:match("^#%x%x%x%x%x%x$") then
    return value
  end

  for part in value:gmatch("[^.]+") do
    if type(colors) ~= "table" then
      return value
    end
    colors = colors[part]
  end

  return colors or value
end

return M
