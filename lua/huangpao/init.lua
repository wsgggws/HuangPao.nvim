local config = require("huangpao.config")
local palette = require("huangpao.palette")

local M = {}

local function resolve_color(colors, value)
  return palette.resolve(colors, value)
end

local function resolve_spec(colors, spec)
  local resolved = {}

  for key, value in pairs(spec) do
    if key == "fg" or key == "bg" or key == "sp" then
      resolved[key] = resolve_color(colors, value)
    else
      resolved[key] = value
    end
  end

  return resolved
end

local function apply_groups(colors, groups)
  for name, spec in pairs(groups) do
    if type(spec) == "string" then
      vim.api.nvim_set_hl(0, name, { link = spec })
    else
      vim.api.nvim_set_hl(0, name, resolve_spec(colors, spec))
    end
  end
end

local function set_terminal_colors(colors)
  if not config.get().terminal_colors then
    return
  end

  vim.g.terminal_color_0 = colors.bg
  vim.g.terminal_color_1 = colors.red
  vim.g.terminal_color_2 = colors.green
  vim.g.terminal_color_3 = colors.yellow
  vim.g.terminal_color_4 = colors.blue
  vim.g.terminal_color_5 = colors.purple
  vim.g.terminal_color_6 = colors.aqua
  vim.g.terminal_color_7 = colors.text
  vim.g.terminal_color_8 = colors.text_faint
  vim.g.terminal_color_9 = colors.red
  vim.g.terminal_color_10 = colors.green
  vim.g.terminal_color_11 = colors.yellow
  vim.g.terminal_color_12 = colors.blue
  vim.g.terminal_color_13 = colors.purple
  vim.g.terminal_color_14 = colors.aqua
  vim.g.terminal_color_15 = colors.text_strong
end

local function create_commands()
  local commands = {
    HuangPaoTransparent = function()
      config.get().transparent = not config.get().transparent
      if vim.g.colors_name == "huangpao" then
        vim.cmd.colorscheme("huangpao")
      end
    end,
  }

  for name, callback in pairs(commands) do
    if vim.fn.exists(":" .. name) == 0 then
      vim.api.nvim_create_user_command(name, callback, {})
    end
  end
end

function M.setup(options)
  config.setup(options)
  create_commands()
  return config.get()
end

function M.load()
  local options = config.get()
  vim.o.background = "light"
  local colors = palette.get()
  local groups = require("huangpao.groups").get(colors, options)

  vim.o.termguicolors = true
  vim.cmd("highlight clear")

  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  vim.g.colors_name = "huangpao"

  -- lualine keeps this module cached between ColorScheme events.
  package.loaded["lualine.themes.huangpao"] = nil

  create_commands()
  apply_groups(colors, groups)
  set_terminal_colors(colors)

  if options.overrides and next(options.overrides) then
    apply_groups(colors, options.overrides)
  end
end

function M.get_palette()
  return palette.get()
end

return M
