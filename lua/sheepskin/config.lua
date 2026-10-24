local M = {}

M.defaults = {
  variant = "auto",
  transparent = false,
  dim_inactive = true,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = false },
    functions = {},
    variables = {},
    type = {},
    diagnostics = { underline = true },
  },
  overrides = {},
}

M.options = vim.deepcopy(M.defaults)

local function copy(value)
  return vim.deepcopy(value)
end

function M.setup(options)
  options = options or {}
  M.options = vim.tbl_deep_extend("force", copy(M.defaults), options)

  if M.options.variant ~= "auto" and M.options.variant ~= "dark" and M.options.variant ~= "light" then
    vim.notify(
      ('sheepskin: invalid variant "%s", falling back to "auto"'):format(tostring(M.options.variant)),
      vim.log.levels.WARN
    )
    M.options.variant = "auto"
  end

  return M.options
end

function M.get()
  return M.options
end

function M.variant()
  if M.options.variant == "auto" then
    return vim.o.background == "light" and "light" or "dark"
  end
  return M.options.variant
end

return M
