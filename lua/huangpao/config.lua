local M = {}

M.defaults = {
  transparent = false,
  dim_inactive = true,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = false },
    functions = { bold = true },
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
  return M.options
end

function M.get()
  return M.options
end

return M
