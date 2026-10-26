local p = require("huangpao.palette").get()

local function mode(accent)
  return {
    a = { fg = p.bg, bg = accent, gui = "bold" },
    b = { fg = p.text, bg = p.bg_selected },
    c = { fg = p.text_muted, bg = p.surface_alt },
  }
end

return {
  normal = mode(p.green),
  insert = mode(p.blue),
  visual = mode(p.purple),
  replace = mode(p.red),
  command = mode(p.yellow),
  terminal = mode(p.aqua),
  inactive = {
    a = { fg = p.text_dim, bg = p.surface_alt },
    b = { fg = p.text_dim, bg = p.surface_alt },
    c = { fg = p.text_dim, bg = p.surface_alt },
  },
}
