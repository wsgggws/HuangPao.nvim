-- nvim --headless -u NONE -l scripts/export.lua [--check]
local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")
vim.opt.runtimepath:prepend(root)
local check = arg[1] == "--check"
assert(arg[1] == nil or (check and arg[2] == nil), "usage: scripts/export.lua [--check]")
local outputs = require("huangpao.extras").get(require("huangpao.palette").get())
for _, name in ipairs(vim.tbl_keys(outputs)) do
  local path, content = root .. "/" .. name, outputs[name]
  local file = io.open(path, "rb")
  local existing = file and file:read("*a")
  if file then
    file:close()
  end
  if existing ~= content then
    assert(not check, "outdated native theme: " .. name .. "; run scripts/export.lua")
    vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
    local output = assert(io.open(path, "wb"))
    assert(output:write(content))
    assert(output:close())
    print(name)
  end
end
