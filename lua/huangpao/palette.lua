local M = {}

local colors = {
  bg = "#cdb06a",
  bg_inactive = "#caad67",
  bg_alt = "#c5a75f",
  bg_highlight = "#bea058",
  bg_selected = "#b08b47",
  bg_visual = "#bcc282",
  surface = "#d4b976",
  surface_alt = "#c2a25d",
  border = "#987d48",
  border_subtle = "#af9251",
  text = "#342f23",
  text_strong = "#252219",
  text_muted = "#504a37",
  text_dim = "#615a43",
  text_faint = "#766b4b",
  comment = "#6b6b65",
  red = "#7d2925",
  orange = "#683b13",
  yellow = "#563e0a",
  green = "#2d4824",
  aqua = "#1e4b3b",
  blue = "#234861",
  purple = "#613457",
  gray = "#4e4937",
  cursor = "#683b13",
  search = "#a7833f",
  match = "#b59852",
  diff_add = "#adb87f",
  diff_delete = "#c39c87",
  diff_change = "#a7b7ad",
  diff_text = "#94aa70",
  diagnostic_error_bg = "#c39c87",
  diagnostic_warn_bg = "#bea35c",
  diagnostic_info_bg = "#a7b7ad",
  diagnostic_hint_bg = "#aabd8f",
}

colors.syntax = {
  comment = colors.comment,
  keyword = "#86312d",
  conditional = "#86312d",
  repeat_ = "#86312d",
  exception = "#86312d",
  operator = colors.orange,
  string = "#4e551f",
  escape = colors.orange,
  regexp = "#4e551f",
  number = "#813e20",
  boolean = colors.purple,
  constant = colors.purple,
  func = "#375a23",
  variable = "#254f78",
  parameter = "#763b65",
  property = "#165744",
  type = "#764718",
  namespace = colors.aqua,
  tag = colors.blue,
  attribute = colors.yellow,
  label = colors.orange,
  punctuation = "#514b38",
  special = colors.orange,
  todo = colors.yellow,
}

-- Callable names share a color; weight separates them from fields and strings.
colors.syntax.method = colors.syntax.func

-- Terminal mouse selections need a stronger boundary than editor selections.
colors.terminal = {
  selection_bg = colors.text_strong,
  selection_fg = colors.surface,
  preview_bg = colors.bg,
  sidebar_bg = colors.surface,
}

function M.get()
  return colors
end

function M.resolve(palette, value)
  if type(value) ~= "string" then
    return value
  end

  if value == "NONE" or value:match("^#%x%x%x%x%x%x$") then
    return value
  end

  for part in value:gmatch("[^.]+") do
    if type(palette) ~= "table" then
      return value
    end
    palette = palette[part]
  end

  return palette or value
end

return M
