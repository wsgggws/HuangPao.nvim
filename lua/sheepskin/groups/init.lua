local M = {}

local modules = {
  require("sheepskin.groups.editor"),
  require("sheepskin.groups.treesitter"),
  require("sheepskin.groups.lsp"),
  require("sheepskin.groups.plugins"),
}

function M.get(colors, options)
  local groups = {}

  for _, module in ipairs(modules) do
    groups = vim.tbl_extend("force", groups, module.get(colors, options))
  end

  return groups
end

return M
