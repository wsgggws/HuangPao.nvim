local M = {}

local modules = {
  require("huangpao.groups.editor"),
  require("huangpao.groups.treesitter"),
  require("huangpao.groups.lsp"),
  require("huangpao.groups.plugins"),
}

function M.get(colors, options)
  local groups = {}

  for _, module in ipairs(modules) do
    groups = vim.tbl_extend("force", groups, module.get(colors, options))
  end

  return groups
end

return M
