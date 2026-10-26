# 黄袍 · 同色板主题

这些文件由 `lua/huangpao/palette.lua` 导出，与 Neovim 使用同一份色板。
这里只分发配色数据，各工具独立导入，不会修改已有个人配置。

| 工具 | 主题文件 | 建议存放位置 |
| --- | --- | --- |
| WezTerm | `wezterm/HuangPao.toml` | `~/.config/wezterm/colors/HuangPao.toml` |
| tmux | `tmux/huangpao.conf` | `~/.config/tmux/themes/huangpao.conf` |
| Oh my tmux! | `tmux/huangpao.oh-my-tmux.conf` | `~/.config/tmux/themes/huangpao.oh-my-tmux.conf` |
| fzf | `fzf/huangpao.sh` | `~/.config/fzf/themes/huangpao.sh` |
| bat | `bat/HuangPao.tmTheme` | `~/.config/bat/themes/HuangPao.tmTheme` |
| delta | `delta/huangpao.gitconfig` | `~/.config/delta/themes/huangpao.gitconfig` |
| Alfred | `alfred/HuangPao Light Large.alfredappearance` | `~/.config/alfred/themes/HuangPao Light Large.alfredappearance` |
| slides / Markdown PPT | `slides/huangpao_theme.json` | 演示文稿目录中的 `huangpao_theme.json` |

Neovim 和 lualine 使用 `huangpao`，WezTerm 与 bat 使用 `HuangPao`，
delta feature 使用 `huangpao`。`palette.json` 是完整色板快照。

## 导入文件

在仓库根目录复制需要的文件；先保留目标位置已有版本：

```sh
mkdir -p ~/.config/wezterm/colors ~/.config/tmux/themes ~/.config/fzf/themes
mkdir -p ~/.config/bat/themes ~/.config/delta/themes ~/.config/alfred/themes
cp extras/wezterm/HuangPao.toml ~/.config/wezterm/colors/
cp extras/tmux/huangpao*.conf ~/.config/tmux/themes/
cp extras/fzf/huangpao.sh ~/.config/fzf/themes/
cp extras/bat/HuangPao.tmTheme ~/.config/bat/themes/
cp extras/delta/huangpao.gitconfig ~/.config/delta/themes/
cp 'extras/alfred/HuangPao Light Large.alfredappearance' ~/.config/alfred/themes/
```

## WezTerm

在现有配置中加入以下字段；若已有自定义目录，追加该路径：

```lua
config.color_scheme_dirs = { wezterm.home_dir .. "/.config/wezterm/colors" }
config.color_scheme = "HuangPao"
```

终端拖选采用玄墨底、暖绢字，与 Neovim 的苔绿选区分开。
tmux 开启鼠标时普通拖选由 copy mode 接管，按住 Shift 可使用 WezTerm 原生选区。

## tmux

普通 tmux 3.2+ 配置中加载：

```tmux
source-file ~/.config/tmux/themes/huangpao.conf
```

文件提供状态栏、窗口状态、边框、消息、复制模式与 popup 样式，保留现有布局和快捷键。
Oh my tmux! 用户将对应文件中的 `status_line_theme`、17 个色板变量和两个 mode 变量
合并到主题变量区。随后重载主配置：

```sh
tmux source-file ~/.tmux.conf
```

## fzf

```sh
. "$HOME/.config/fzf/themes/huangpao.sh"
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:-} --color=$FZF_THEME_COLOR"
```

`FZF_THEME_NAME` 为显示名称，`FZF_THEME_COLOR` 为颜色选项，
`FZF_THEME_PREVIEW_CMD` 为 bat 预览命令。预览命令还需要在末尾传入文件名，
例如 `fzf --preview "$FZF_THEME_PREVIEW_CMD {}"`。

列表使用侧栏色 `#d4b976`，预览使用纸色 `#cdb06a`；
预览的内容、滚动、快捷键和源 ANSI 颜色处理由调用程序负责。

## bat

在 `~/.config/bat/config` 中设置：

```text
--theme="HuangPao"
```

首次复制或更新主题文件后执行 `bat cache --build`，再用 `bat --list-themes` 确认注册。
变量、参数、属性、函数、注释与 Neovim 在能识别的语义范围内使用相同颜色。

## Git diff / delta

在 Git 配置中加入：

```gitconfig
[include]
    path = ~/.config/delta/themes/huangpao.gitconfig
[delta]
    features = huangpao
```

已有 `[delta]` 中直接设置的样式可能覆盖 feature；保留旧配置时将对应项注释。
delta 通过 bat 缓存加载 `HuangPao`，因此要先完成 bat 主题安装。
如原本已使用其他 feature，将 `huangpao` 追加到列表。

## Alfred

打开 `HuangPao Light Large.alfredappearance` 导入，
然后在 Alfred 外观设置中选择 `HuangPao Light Large`。
尺寸参考 Alfred Modern Dark Large：窗口宽 760，搜索字体 36，结果字体 18。
暖绢底、较深的选中项与玄墨文字均使用本主题色板。

`alfred/huangpao.plist` 保留已安装黄袍主题的 UUID，供已有个人切换工具使用。
新用户正常导入外观即可，Alfred 分配的主题身份不必与此文件相同，
无需覆盖整份 Alfred 偏好设置。

## slides / Markdown PPT

将 `slides/huangpao_theme.json` 复制到文稿目录，在文稿开头指定：

```yaml
---
theme: ./huangpao_theme.json
---
```

路径相对于启动 `slides` 的工作目录，也可以使用绝对路径。
文件为 Glamour JSON，包含正文、标题、引用、链接、diff 和 Chroma 代码配色。
日期、作者栏等应用界面可能由 slides 自身控制；主题不设字号。

## 更新与检查

从仓库根目录运行：

```sh
nvim --headless -u NONE -l scripts/export.lua
nvim --headless -u NONE -l scripts/export.lua --check
make test
```

导出只写入本仓库的 `extras/`，不会安装或覆盖个人配置。
修改映射后重新导出并检查原生文件；个人统一切换和窗口选择器在各自配置目录维护。
