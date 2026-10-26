# 贡献与维护

黄袍以古绢暖黄与玄墨文字为底色，优先保持代码清晰、注释克制、语法层级可辨。
当前只提供浅色配色；修改颜色时同时检查代码、诊断、选区、diff 与终端预览。

## 环境

- Neovim 0.9+；CI 覆盖 0.9.5、0.10.4、stable 与 nightly。
- StyLua：Lua 格式检查。
- Python 3：解析验证跨工具主题，不需要第三方库。
- 可选 `uv`：为截图脚本安装隔离依赖，主题本身不依赖 Python。

## 配色与导出

颜色集中在 `lua/huangpao/palette.lua`，高亮角色位于 `lua/huangpao/groups/`。
跨工具映射由 `lua/huangpao/extras.lua` 和 `lua/huangpao/extras/native.lua` 维护。
修改后执行：

```sh
nvim --headless -u NONE -l scripts/export.lua
make test
stylua --check .
```

生成文件随源码保存在 `extras/`，方便用户直接导入。导出与预览都不修改个人应用配置。
Neovim、Tree-sitter、LSP、bat 与 slides 在各自能识别的角色范围内保持一致；
不要为了模拟不存在的参数 token 而把所有变量都染成参数色。

`make test` 检查加载、语义高亮、选项、选区对比、原生文件同步、帮助标签与预览。
Python 检查使用 plistlib、JSON 和 Git 解析实际原生文件；自动测试不能替代所有插件和应用的人工验收。

## 预览与截图

```sh
nvim -u scripts/preview.lua
uv run scripts/screenshot.py
```

预览独立于个人插件配置，展示示例代码与配色面板；诊断和 Git 标记是明确的演示数据。
有 Lua parser 时启用 Tree-sitter，没有时退回 Vim syntax。
截图脚本捕获实际 Neovim UI 网格，输出 `assets/huangpao-light.png`。
生成后检查中文、斜体、下划线、文本裁切和背景是否正确。

脚本会查找常见等宽与中文字体，也可显式指定：

```sh
uv run scripts/screenshot.py --font /path/to/monospace.ttf --cjk-font /path/to/chinese.ttc
```

截图工具改编自 QingShan.nvim，保留其 MIT 版权声明。截图依赖仅用于开发。

## 提交前

```sh
nvim --headless -u NONE -l scripts/export.lua --check
make test
stylua --check .
git diff --check
```

选项、集成或安装方式变化时同步更新 README、`:help huangpao` 与相关导入说明。
不要把个人账户的切换脚本、tmux 窗口选择器或应用自动化加入主题加载路径。
准备文件不会自动提交、推送或发布。
