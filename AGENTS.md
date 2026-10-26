# HuangPao.nvim 维护约定

- 仓库名为 `HuangPao.nvim`，模块、colorscheme 与 lualine 为 `huangpao`；兼容 Neovim 0.9+。
- 仅维护当前浅色版本。颜色只定义在 `lua/huangpao/palette.lua`，高亮在 `groups/`，默认选项在 `config.lua`。
- 保持注释、变量、参数、属性与函数的可读层级；高亮构建函数接收色板和选项，返回定义表。
- `setup()` 可省略，标准 colorscheme 加载可重复且不依赖插件。
- 修改原生导出时阅读 [extras/README.md](extras/README.md)，更新 `lua/huangpao/extras.lua` 并重新生成文件。
- 公开选项与使用方式变更同步 README。个人切换和应用交互脚本归对应配置目录。

完成修改前运行：

```sh
make test
nvim --headless -u NONE -l scripts/export.lua --check
stylua --check .
```

配色变更需检查实际显示并更新截图；文档修改无需重建截图。报告检查结果与未验证范围。发布标签和推送仅在用户明确要求时执行。
