-- nvim --headless -u scripts/preview.lua -c 'luafile tests/preview.lua'
-- Exercise the fallback used when no bundled Lua parser is installed.
vim.treesitter.start = function()
  error("preview test: parser intentionally unavailable")
end
vim.schedule(function()
  local ok, err = pcall(function()
    assert(vim.v.errmsg == "", vim.v.errmsg)
    assert(vim.g.colors_name == "huangpao", "preview did not load theme")
    assert(vim.o.loadplugins == false, "preview must not load personal plugins")
    assert(vim.fn.expand("%:t") == "showcase.lua", "preview did not open the showcase")
    assert(vim.bo.syntax == "lua", "preview must fall back to Vim syntax")
    assert(vim.fn.synIDattr(vim.fn.synID(17, 1, 1), "name") ~= "", "fallback must actually highlight code")
    assert(#vim.api.nvim_list_wins() == 2, "preview must contain code and palette")
    local source = vim.api.nvim_get_current_buf()
    local diagnostics = vim.diagnostic.get(source)
    assert(#diagnostics == 3, "preview diagnostic fixtures are missing")
    for _, diagnostic in ipairs(diagnostics) do
      local line = vim.api.nvim_buf_get_lines(source, diagnostic.lnum, diagnostic.lnum + 1, false)[1]
      assert(line and diagnostic.col < #line, "diagnostic points outside the example")
    end
    local panel
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if buf ~= source then
        panel = buf
      end
    end
    assert(panel and vim.bo[panel].buftype == "nofile", "palette must be a scratch buffer")
    local lines = table.concat(vim.api.nvim_buf_get_lines(panel, 0, -1, false), "\n")
    assert(lines:find("#cdb06a", 1, true), "preview must show the accepted paper color")
    assert(lines:find("parameter", 1, true) and lines:find("changed line", 1, true), "palette roles missing")

    -- Check help tags without writing generated files to the repository.
    local temp = vim.fn.tempname()
    vim.fn.mkdir(temp .. "/doc", "p")
    vim.fn.writefile(vim.fn.readfile("doc/huangpao.txt"), temp .. "/doc/huangpao.txt")
    local help_ok, help_err = pcall(function()
      vim.cmd("helptags " .. vim.fn.fnameescape(temp .. "/doc"))
      vim.opt.runtimepath:prepend(temp)
      vim.cmd("help huangpao")
      assert(vim.bo.filetype == "help", "help entry is not accessible")
      vim.cmd("help huangpao-extras")
      assert(vim.fn.expand("%:t") == "huangpao.txt", "extras help tag is missing")
    end)
    vim.fn.delete(temp, "rf")
    assert(help_ok, help_err)
  end)
  if not ok then
    vim.api.nvim_err_writeln(tostring(err))
    vim.cmd("cquit 1")
    return
  end
  print("huangpao preview and help tests passed")
  vim.cmd("qa!")
end)
