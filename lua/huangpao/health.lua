local M = {}

function M.check()
  local health = vim.health or require("health")
  local start = health.start or health.report_start
  local ok = health.ok or health.report_ok
  local warn = health.warn or health.report_warn

  start("HuangPao.nvim")

  if vim.fn.has("nvim-0.9") == 1 then
    ok("Neovim 0.9+ is available")
  else
    warn("HuangPao.nvim targets Neovim 0.9 or newer")
  end

  if vim.g.colors_name == "huangpao" then
    ok("huangpao is the active colorscheme")
  else
    warn(("huangpao is not active (current: %s)"):format(vim.g.colors_name or "default"))
  end

  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  if normal.bg and normal.fg then
    ok(("Normal highlight is configured (#%06x on #%06x)"):format(normal.fg, normal.bg))
  elseif vim.g.colors_name == "huangpao" then
    warn("Normal uses a transparent or partially defined background")
  end

  ok(("Current background: %s"):format(vim.o.background))
  ok(("Transparency: %s"):format(tostring(require("huangpao.config").get().transparent)))
end

return M
