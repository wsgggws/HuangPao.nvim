-- Standalone preview: nvim -u scripts/preview.lua
local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")
vim.opt.runtimepath:prepend(root)
vim.opt.loadplugins = false
vim.opt.shadafile = "NONE"
vim.opt.swapfile = false
vim.opt.undofile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.number = true
vim.opt.signcolumn = "yes:1"
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.scrolloff = 3
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.fillchars = { eob = " ", vert = "│" }
vim.opt.shortmess:append("I")
vim.opt.statusline = "  %t %m%r %= HuangPao   %{&filetype}   %l:%c  "
vim.cmd("filetype plugin off")
vim.cmd("filetype indent on")
vim.cmd("syntax on")
vim.cmd.colorscheme("huangpao")

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  nested = true,
  callback = function()
    local demo = vim.fn.argc() == 0
    if demo then
      vim.cmd.edit(vim.fn.fnameescape(root .. "/examples/showcase.lua"))
    end
    -- Only the bundled showcase assumes Lua; user-supplied files keep their syntax.
    if demo and not pcall(vim.treesitter.start, 0, "lua") then
      vim.bo.syntax = "lua"
    end
    local source = vim.api.nvim_get_current_buf()
    local ns = vim.api.nvim_create_namespace("huangpao-preview")
    if demo then
      vim.diagnostic.config({ virtual_text = { prefix = "●", spacing = 3 }, underline = true, signs = false })
      vim.diagnostic.set(ns, source, {
        { lnum = 11, col = 2, severity = vim.diagnostic.severity.WARN, message = "demo: ink density" },
        { lnum = 17, col = 16, severity = vim.diagnostic.severity.ERROR, message = "demo: error text" },
        { lnum = 26, col = 2, severity = vim.diagnostic.severity.INFO, message = "demo: contract" },
      })
      vim.fn.sign_define("HuangPaoPreviewAdd", { text = "+", texthl = "GitSignsAdd" })
      vim.fn.sign_define("HuangPaoPreviewChange", { text = "~", texthl = "GitSignsChange" })
      vim.fn.sign_place(0, "huangpao-preview", "HuangPaoPreviewAdd", source, { lnum = 22 })
      vim.fn.sign_place(0, "huangpao-preview", "HuangPaoPreviewChange", source, { lnum = 30 })
      vim.api.nvim_win_set_cursor(0, { 17, 15 })
    end

    local p = require("huangpao").get_palette()
    local rows = {
      { "黄袍加身", "Title" },
      { "HuangPao", "Comment" },
      { "", "Normal" },
      { "黄裳元吉，文在中也。", "Comment" },
      { "", "Normal" },
      { "PALETTE", "Title" },
      { "", "Normal" },
      { "古绢   " .. p.bg, "Normal" },
      { "朱砂   " .. p.syntax.keyword, "Keyword" },
      { "苍苔   " .. p.syntax.func, "Function" },
      { "玄墨   " .. p.text, "Normal" },
      { "赭石   " .. p.syntax.number, "Number" },
      { "灰墨   " .. p.comment, "Comment" },
      { "", "Normal" },
      { "EDITOR", "Title" },
      { "", "Normal" },
      { "keyword   local / return", "Keyword" },
      { "function  blend_ink()", "Function" },
      { "string    warm silk", "String" },
      { "number    0.85 / 3", "Number" },
      { "comment   quiet notes", "Comment" },
      { "", "Normal" },
      { "DIAGNOSTICS", "Title" },
      { "", "Normal" },
      { "E  error:   cinnabar", "DiagnosticError" },
      { "W  warning: old gold", "DiagnosticWarn" },
      { "I  info:    deep blue", "DiagnosticInfo" },
      { "H  hint:    moss green", "DiagnosticHint" },
      { "", "Normal" },
      { "SURFACES", "Title" },
      { "", "Normal" },
      { "selected text", "Visual" },
      { "search match", "Search" },
      { "current match", "CurSearch" },
      { "", "Normal" },
      { "variable   scroll", "Identifier" },
      { "parameter  density", "@variable.parameter" },
      { "No plugins required.", "Comment" },
    }
    vim.cmd("botright 36vnew")
    local panel = vim.api.nvim_get_current_buf()
    vim.bo[panel].buftype = "nofile"
    vim.bo[panel].bufhidden = "wipe"
    vim.bo[panel].swapfile = false
    vim.api.nvim_buf_set_name(panel, "HuangPao / palette")
    local lines = { "" }
    for _, row in ipairs(rows) do
      lines[#lines + 1] = "  " .. row[1]
    end
    vim.api.nvim_buf_set_lines(panel, 0, -1, false, lines)
    vim.bo[panel].modifiable = false
    vim.wo.number = false
    vim.wo.signcolumn = "no"
    vim.wo.cursorline = false
    vim.wo.winfixwidth = true
    for index, row in ipairs(rows) do
      if row[1] ~= "" then
        vim.api.nvim_buf_set_extmark(panel, ns, index, 2, { end_col = #lines[index + 1], hl_group = row[2] })
      end
    end
    vim.cmd("wincmd p")
  end,
})
