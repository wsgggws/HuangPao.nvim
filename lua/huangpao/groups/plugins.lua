local M = {}

local function add_plugin_groups(groups, p)
  -- Snacks (LazyVim's default picker and UI components)
  groups.SnacksPicker = { fg = p.text, bg = p.surface }
  groups.SnacksPickerBorder = { fg = p.border, bg = p.surface }
  groups.SnacksPickerTitle = { fg = p.yellow, bold = true }
  groups.SnacksPickerInput = { fg = p.text, bg = p.surface_alt }
  groups.SnacksPickerInputBorder = { fg = p.border, bg = p.surface_alt }
  groups.SnacksPickerInputTitle = { fg = p.yellow, bold = true }
  groups.SnacksPickerList = { fg = p.text, bg = p.surface }
  groups.SnacksPickerListBorder = { fg = p.border, bg = p.surface }
  groups.SnacksPickerPreview = { fg = p.text, bg = p.surface }
  groups.SnacksPickerPreviewBorder = { fg = p.border, bg = p.surface }
  groups.SnacksPickerListCursorLine = { fg = p.text_strong, bg = p.bg_selected }
  groups.SnacksPickerCursorLine = { fg = p.text_strong, bg = p.bg_selected }
  groups.SnacksPickerMatch = { fg = p.orange, bold = true }
  groups.SnacksPickerDir = { fg = p.text_muted }
  groups.SnacksPickerFile = { fg = p.text }
  groups.SnacksPickerIcon = { fg = p.blue }
  groups.SnacksPickerLabel = { fg = p.aqua }
  groups.SnacksPickerBufNr = { fg = p.text_faint }
  groups.SnacksPickerCol = { fg = p.text_faint }
  groups.SnacksPickerRow = { fg = p.text_faint }
  groups.SnacksPickerSearch = { fg = p.orange }
  groups.SnacksPickerPrompt = { fg = p.green }
  groups.SnacksPickerToggle = { fg = p.text_muted }
  groups.SnacksPickerTree = { fg = p.text_faint }
  groups.SnacksPickerIndent = { fg = p.border_subtle }
  groups.SnacksPickerSpinner = { fg = p.yellow }
  groups.SnacksPickerKeymap = { fg = p.text_faint }

  -- Telescope
  groups.TelescopeNormal = { fg = p.text, bg = p.surface }
  groups.TelescopeBorder = { fg = p.border, bg = p.surface }
  groups.TelescopeTitle = { fg = p.yellow, bold = true }
  groups.TelescopePromptNormal = { fg = p.text, bg = p.surface_alt }
  groups.TelescopePromptBorder = { fg = p.border, bg = p.surface_alt }
  groups.TelescopePromptTitle = { fg = p.green, bg = p.surface_alt, bold = true }
  groups.TelescopeResultsNormal = { fg = p.text, bg = p.surface }
  groups.TelescopeResultsBorder = { fg = p.border, bg = p.surface }
  groups.TelescopeResultsTitle = { fg = p.yellow, bold = true }
  groups.TelescopePreviewNormal = { fg = p.text, bg = p.surface }
  groups.TelescopePreviewBorder = { fg = p.border, bg = p.surface }
  groups.TelescopePreviewTitle = { fg = p.aqua, bold = true }
  groups.TelescopeSelection = { fg = p.text_strong, bg = p.bg_selected, bold = true }
  groups.TelescopeSelectionCaret = { fg = p.orange, bg = p.bg_selected }
  groups.TelescopeMultiSelection = { fg = p.yellow, bg = p.bg_selected }
  groups.TelescopeMatching = { fg = p.orange, bold = true }
  groups.TelescopePromptPrefix = { fg = p.green }
  groups.TelescopePreviewLine = { bg = p.bg_highlight }
  groups.TelescopePreviewMatch = { fg = p.text_strong, bg = p.search }
  groups.TelescopeResultsComment = { fg = p.syntax.comment }
  groups.TelescopeResultsDiffAdd = { fg = p.green }
  groups.TelescopeResultsDiffChange = { fg = p.yellow }
  groups.TelescopeResultsDiffDelete = { fg = p.red }
  groups.TelescopeResultsField = { fg = p.syntax.property }
  groups.TelescopeResultsFunction = { fg = p.syntax.func }
  groups.TelescopeResultsIdentifier = { fg = p.syntax.variable }
  groups.TelescopeResultsNumber = { fg = p.syntax.number }
  groups.TelescopeResultsOperator = { fg = p.syntax.operator }
  groups.TelescopeResultsString = { fg = p.syntax.string }
  groups.TelescopeResultsVariable = { fg = p.syntax.variable }

  -- neo-tree
  groups.NeoTreeNormal = { fg = p.text, bg = p.surface }
  groups.NeoTreeNormalNC = { fg = p.text_muted, bg = p.surface }
  groups.NeoTreeWinSeparator = { fg = p.border_subtle, bg = p.surface }
  groups.NeoTreeEndOfBuffer = { fg = p.surface, bg = p.surface }
  groups.NeoTreeRootName = { fg = p.yellow, bold = true }
  groups.NeoTreeDirectoryName = { fg = p.blue }
  groups.NeoTreeDirectoryIcon = { fg = p.blue }
  groups.NeoTreeFileName = { fg = p.text }
  groups.NeoTreeFileNameOpened = { fg = p.yellow, bold = true }
  groups.NeoTreeFileIcon = { fg = p.text_muted }
  groups.NeoTreeIndentMarker = { fg = p.border_subtle }
  groups.NeoTreeExpander = { fg = p.text_muted }
  groups.NeoTreeSymbolIcon = { fg = p.aqua }
  groups.NeoTreeFloatNormal = { fg = p.text, bg = p.surface }
  groups.NeoTreeFloatBorder = { fg = p.border, bg = p.surface }
  groups.NeoTreeFloatTitle = { fg = p.yellow, bold = true }
  groups.NeoTreeTitleBar = { fg = p.surface_alt, bg = p.yellow, bold = true }
  groups.NeoTreeGitAdded = { fg = p.green }
  groups.NeoTreeGitModified = { fg = p.yellow }
  groups.NeoTreeGitDeleted = { fg = p.red }
  groups.NeoTreeGitRenamed = { fg = p.aqua }
  groups.NeoTreeGitUntracked = { fg = p.blue }
  groups.NeoTreeGitIgnored = { fg = p.text_faint }
  groups.NeoTreeGitConflict = { fg = p.orange, bold = true }
  groups.NeoTreeCursorLine = { bg = p.bg_selected }
  groups.NeoTreeStatusLine = { fg = p.text_muted, bg = p.surface_alt }

  -- nvim-tree
  groups.NvimTreeNormal = { fg = p.text, bg = p.surface }
  groups.NvimTreeNormalNC = { fg = p.text_muted, bg = p.surface }
  groups.NvimTreeWinSeparator = { fg = p.border_subtle, bg = p.surface }
  groups.NvimTreeRootFolder = { fg = p.yellow, bold = true }
  groups.NvimTreeFolderName = { fg = p.blue }
  groups.NvimTreeOpenedFolderName = { fg = p.blue, bold = true }
  groups.NvimTreeEmptyFolderName = { fg = p.text_muted }
  groups.NvimTreeFolderIcon = { fg = p.blue }
  groups.NvimTreeIndentMarker = { fg = p.border_subtle }
  groups.NvimTreeGitDirty = { fg = p.yellow }
  groups.NvimTreeGitStaged = { fg = p.green }
  groups.NvimTreeGitMerge = { fg = p.orange, bold = true }
  groups.NvimTreeGitRenamed = { fg = p.aqua }
  groups.NvimTreeGitNew = { fg = p.green }
  groups.NvimTreeGitDeleted = { fg = p.red }
  groups.NvimTreeSpecialFile = { fg = p.purple, bold = true }
  groups.NvimTreeSymlink = { fg = p.aqua }
  groups.NvimTreeExecFile = { fg = p.green, bold = true }
  groups.NvimTreeImageFile = { fg = p.purple }
  groups.NvimTreeOpenedFile = { fg = p.yellow, bold = true }
  groups.NvimTreeModifiedFile = { fg = p.yellow }
  groups.NvimTreeCursorLine = { bg = p.bg_selected }
  groups.NvimTreeCursorLineNr = { fg = p.cursor, bold = true }
  groups.NvimTreeStatusLine = { fg = p.text_muted, bg = p.surface_alt }

  -- bufferline
  groups.BufferLineFill = { fg = p.text_muted, bg = p.bg_alt }
  groups.BufferLineBackground = { fg = p.text_muted, bg = p.bg_alt }
  groups.BufferLineBufferVisible = { fg = p.text_muted, bg = p.bg_alt }
  groups.BufferLineBufferSelected = { fg = p.text_strong, bg = p.bg, bold = true }
  groups.BufferLineTab = { fg = p.text_muted, bg = p.bg_alt }
  groups.BufferLineTabSelected = { fg = p.text_strong, bg = p.bg, bold = true }
  groups.BufferLineTabSeparator = { fg = p.border, bg = p.bg_alt }
  groups.BufferLineTabSeparatorSelected = { fg = p.border, bg = p.bg }
  groups.BufferLineCloseButton = { fg = p.text_faint, bg = p.bg_alt }
  groups.BufferLineCloseButtonVisible = { fg = p.text_muted, bg = p.bg_alt }
  groups.BufferLineCloseButtonSelected = { fg = p.red, bg = p.bg }
  groups.BufferLineModified = { fg = p.orange, bg = p.bg_alt }
  groups.BufferLineModifiedVisible = { fg = p.orange, bg = p.bg_alt }
  groups.BufferLineModifiedSelected = { fg = p.orange, bg = p.bg }
  groups.BufferLineSeparator = { fg = p.border, bg = p.bg_alt }
  groups.BufferLineSeparatorVisible = { fg = p.border, bg = p.bg_alt }
  groups.BufferLineSeparatorSelected = { fg = p.border, bg = p.bg }
  groups.BufferLineNumbers = { fg = p.text_faint, bg = p.bg_alt }
  groups.BufferLineNumbersSelected = { fg = p.cursor, bg = p.bg }
  groups.BufferLineIndicatorSelected = { fg = p.orange, bg = p.bg }
  groups.BufferLineError = { fg = p.red }
  groups.BufferLineWarning = { fg = p.yellow }
  groups.BufferLineInfo = { fg = p.blue }
  groups.BufferLineHint = { fg = p.aqua }
  groups.BufferLineHintDiagnostic = { fg = p.aqua }
  groups.BufferLineDiagnosticsInfo = { fg = p.blue }
  groups.BufferLineDiagnosticsWarning = { fg = p.yellow }
  groups.BufferLineDiagnosticsError = { fg = p.red }
  groups.BufferLineCloseButtonDiagnosticError = { fg = p.red }
  groups.BufferLineCloseButtonDiagnosticWarning = { fg = p.yellow }
  groups.BufferLineCloseButtonDiagnosticInfo = { fg = p.blue }
  groups.BufferLineCloseButtonDiagnosticHint = { fg = p.aqua }

  -- gitsigns
  groups.GitSignsAdd = { fg = p.green }
  groups.GitSignsChange = { fg = p.yellow }
  groups.GitSignsDelete = { fg = p.red }
  groups.GitSignsTopdelete = { fg = p.red }
  groups.GitSignsChangedelete = { fg = p.orange }
  groups.GitSignsUntracked = { fg = p.blue }
  groups.GitSignsAddNr = { fg = p.green }
  groups.GitSignsChangeNr = { fg = p.yellow }
  groups.GitSignsDeleteNr = { fg = p.red }
  groups.GitSignsTopdeleteNr = { fg = p.red }
  groups.GitSignsChangedeleteNr = { fg = p.orange }
  groups.GitSignsUntrackedNr = { fg = p.blue }
  groups.GitSignsAddLn = { bg = p.diff_add }
  groups.GitSignsChangeLn = { bg = p.diff_change }
  groups.GitSignsDeleteLn = { bg = p.diff_delete }
  groups.GitSignsAddInline = { bg = p.diff_add }
  groups.GitSignsChangeInline = { bg = p.diff_change }
  groups.GitSignsDeleteInline = { bg = p.diff_delete }
  groups.GitSignsWordAdd = { bg = p.diff_text }
  groups.GitSignsWordChange = { bg = p.diff_text }
  groups.GitSignsWordDelete = { bg = p.diff_delete }

  -- which-key
  groups.WhichKey = { fg = p.yellow, bold = true }
  groups.WhichKeyGroup = { fg = p.blue }
  groups.WhichKeyDesc = { fg = p.text }
  groups.WhichKeySeparator = { fg = p.text_faint }
  groups.WhichKeyFloat = { bg = p.surface }
  groups.WhichKeyBorder = { fg = p.border, bg = p.surface }
  groups.WhichKeyValue = { fg = p.text_muted }
  groups.WhichKeyTitle = { fg = p.yellow, bold = true }
  groups.WhichKeyIconAzure = { fg = p.blue }
  groups.WhichKeyIconBlue = { fg = p.blue }
  groups.WhichKeyIconCyan = { fg = p.aqua }
  groups.WhichKeyIconGreen = { fg = p.green }
  groups.WhichKeyIconGrey = { fg = p.text_muted }
  groups.WhichKeyIconOrange = { fg = p.orange }
  groups.WhichKeyIconPurple = { fg = p.purple }
  groups.WhichKeyIconRed = { fg = p.red }
  groups.WhichKeyIconYellow = { fg = p.yellow }

  -- indent-blankline
  groups.IblIndent = { fg = p.border_subtle }
  groups.IblScope = { fg = p.border }
  groups.IblWhitespace = { fg = p.border_subtle }

  -- nvim-cmp
  groups.CmpItemAbbr = { fg = p.text }
  groups.CmpItemAbbrDeprecated = { fg = p.text_faint, strikethrough = true }
  groups.CmpItemAbbrMatch = { fg = p.orange, bold = true }
  groups.CmpItemAbbrMatchFuzzy = { fg = p.orange, bold = true }
  groups.CmpItemKind = { fg = p.aqua }
  groups.CmpItemMenu = { fg = p.text_muted, italic = true }
  groups.CmpGhostText = { fg = p.text_faint, italic = true }
  groups.CmpDocumentation = { fg = p.text, bg = p.surface }
  groups.CmpDocumentationBorder = { fg = p.border, bg = p.surface }

  -- blink.cmp
  groups.BlinkCmpMenu = { fg = p.text, bg = p.surface }
  groups.BlinkCmpMenuBorder = { fg = p.border, bg = p.surface }
  groups.BlinkCmpMenuSelection = { fg = p.text_strong, bg = p.bg_selected }
  groups.BlinkCmpScrollBarThumb = { bg = p.border }
  groups.BlinkCmpScrollBarGutter = { bg = p.bg_alt }
  groups.BlinkCmpLabel = { fg = p.text }
  groups.BlinkCmpLabelDeprecated = { fg = p.text_faint, strikethrough = true }
  groups.BlinkCmpLabelMatch = { fg = p.orange, bold = true }
  groups.BlinkCmpLabelDetail = { fg = p.text_muted }
  groups.BlinkCmpLabelDescription = { fg = p.text_faint }
  groups.BlinkCmpLabelDetailDescription = { fg = p.text_faint }
  groups.BlinkCmpSource = { fg = p.aqua }
  groups.BlinkCmpSourceName = { fg = p.aqua }
  groups.BlinkCmpKind = { fg = p.blue }
  groups.BlinkCmpGhostText = { fg = p.text_faint, italic = true }

  -- Trouble
  groups.TroubleNormal = { fg = p.text, bg = p.surface }
  groups.TroubleBorder = { fg = p.border, bg = p.surface }
  groups.TroubleText = { fg = p.text }
  groups.TroubleFile = { fg = p.blue }
  groups.TroubleDirectory = { fg = p.blue, bold = true }
  groups.TroubleFoldIcon = { fg = p.text_muted }
  groups.TroubleIcon = { fg = p.aqua }
  groups.TroubleIndent = { fg = p.border_subtle }
  groups.TroublePos = { fg = p.text_faint }
  groups.TroubleCount = { fg = p.orange }
  groups.TroubleCode = { fg = p.red }
  groups.TroubleSource = { fg = p.text_muted }
  groups.TroublePreview = { bg = p.bg_selected }
  groups.TroubleSignError = { fg = p.red }
  groups.TroubleSignWarning = { fg = p.yellow }
  groups.TroubleSignInformation = { fg = p.blue }
  groups.TroubleSignHint = { fg = p.aqua }

  -- lazy.nvim
  groups.LazyNormal = { fg = p.text, bg = p.surface }
  groups.LazyButton = { fg = p.text, bg = p.bg_selected }
  groups.LazyButtonActive = { fg = p.text_strong, bg = p.orange, bold = true }
  groups.LazyH1 = { fg = p.text_strong, bg = p.orange, bold = true }
  groups.LazyH2 = { fg = p.orange, bold = true }
  groups.LazySpecial = { fg = p.aqua }
  groups.LazyCommit = { fg = p.yellow }
  groups.LazyValue = { fg = p.blue }
  groups.LazyDir = { fg = p.blue }
  groups.LazyUrl = { fg = p.aqua, underline = true }
  groups.LazyNoCond = { fg = p.text_faint }
  groups.LazyProgressDone = { fg = p.green, bold = true }
  groups.LazyProgressTodo = { fg = p.border }
  groups.LazyProp = { fg = p.text_muted }
  groups.LazyReasonRuntime = { fg = p.blue }
  groups.LazyReasonPlugin = { fg = p.aqua }
  groups.LazyReasonKeys = { fg = p.purple }
  groups.LazyReasonEvent = { fg = p.yellow }
  groups.LazyReasonCmd = { fg = p.orange }
  groups.LazyReasonFt = { fg = p.green }

  -- noice.nvim
  groups.NoiceCmdline = { fg = p.text, bg = p.surface }
  groups.NoiceCmdlineIcon = { fg = p.green }
  groups.NoiceCmdlineIconSearch = { fg = p.yellow }
  groups.NoiceCmdlinePopup = { fg = p.text, bg = p.surface }
  groups.NoiceCmdlinePopupBorder = { fg = p.border, bg = p.surface }
  groups.NoiceCmdlinePopupTitle = { fg = p.yellow, bold = true }
  groups.NoiceCmdlinePrompt = { fg = p.green }
  groups.NoiceConfirm = { fg = p.text, bg = p.surface }
  groups.NoiceConfirmBorder = { fg = p.border, bg = p.surface }
  groups.NoiceCursor = { fg = p.bg, bg = p.cursor }
  groups.NoiceMini = { fg = p.text_muted, bg = p.surface_alt }
  groups.NoicePopup = { fg = p.text, bg = p.surface }
  groups.NoicePopupBorder = { fg = p.border, bg = p.surface }
  groups.NoiceSplit = { fg = p.text, bg = p.surface }
  groups.NoiceSplitBorder = { fg = p.border, bg = p.surface }
  groups.NoiceLspProgressSpinner = { fg = p.yellow }

  -- nvim-notify
  for _, level in ipairs({ "ERROR", "WARN", "INFO", "DEBUG", "TRACE" }) do
    local color = ({
      ERROR = p.red,
      WARN = p.yellow,
      INFO = p.blue,
      DEBUG = p.aqua,
      TRACE = p.text_muted,
    })[level]
    groups["Notify" .. level .. "Border"] = { fg = color, bg = p.surface }
    groups["Notify" .. level .. "Title"] = { fg = color, bg = p.surface, bold = true }
    groups["Notify" .. level .. "Icon"] = { fg = color, bg = p.surface }
    groups["Notify" .. level .. "Body"] = { fg = p.text, bg = p.surface }
  end
  groups.NotifyBackground = { fg = p.text, bg = p.surface }

  -- nvim-dap / nvim-dap-ui
  groups.DapBreakpoint = { fg = p.red }
  groups.DapBreakpointCondition = { fg = p.orange }
  groups.DapBreakpointRejected = { fg = p.text_faint }
  groups.DapLogPoint = { fg = p.yellow }
  groups.DapStopped = { fg = p.yellow, bg = p.diagnostic_warn_bg }
  groups.DapStoppedLine = { bg = p.diagnostic_warn_bg }
  groups.DapUIBreakpointsCurrentLine = { fg = p.yellow, bg = p.diagnostic_warn_bg }
  groups.DapUIBreakpointsDisabledLine = { fg = p.text_faint }
  groups.DapUIBreakpointsInfo = { fg = p.blue }
  groups.DapUIBreakpointsPath = { fg = p.aqua }
  groups.DapUIDecoration = { fg = p.orange }
  groups.DapUIFloatBorder = { fg = p.border, bg = p.surface }
  groups.DapUILineNumber = { fg = p.text_faint }
  groups.DapUIModifiedValue = { fg = p.yellow, bold = true }
  groups.DapUIPlayPause = { fg = p.green }
  groups.DapUIRestart = { fg = p.green }
  groups.DapUIScope = { fg = p.yellow }
  groups.DapUISource = { fg = p.blue }
  groups.DapUIType = { fg = p.aqua }
  groups.DapUIUnavailable = { fg = p.text_faint }
  groups.DapUIWatchesEmpty = { fg = p.text_faint }
  groups.DapUIWatchesError = { fg = p.red }
  groups.DapUIWatchesValue = { fg = p.orange }

  -- dashboard-nvim and alpha-nvim
  groups.DashboardHeader = { fg = p.yellow, bold = true }
  groups.DashboardFooter = { fg = p.text_muted }
  groups.DashboardCenter = { fg = p.blue }
  groups.DashboardShortcut = { fg = p.aqua }
  groups.DashboardShortcutIcon = { fg = p.orange }
  groups.DashboardProjectTitle = { fg = p.text_muted, bold = true }
  groups.DashboardProjectIcon = { fg = p.green }
  groups.DashboardMruTitle = { fg = p.text_muted, bold = true }
  groups.DashboardMruIcon = { fg = p.green }
  groups.DashboardFiles = { fg = p.text }
  groups.DashboardRecentFiles = { fg = p.text }
  groups.DashboardKey = { fg = p.orange }
  groups.DashboardDesc = { fg = p.text_muted }
  groups.AlphaHeader = { fg = p.yellow, bold = true }
  groups.AlphaButtons = { fg = p.text }
  groups.AlphaShortcut = { fg = p.orange }
  groups.AlphaFooter = { fg = p.text_muted }
  groups.AlphaJumplist = { fg = p.blue }

  -- mini.nvim
  groups.MiniFilesNormal = { fg = p.text, bg = p.surface }
  groups.MiniFilesBorder = { fg = p.border, bg = p.surface }
  groups.MiniFilesDirectory = { fg = p.blue }
  groups.MiniFilesFile = { fg = p.text }
  groups.MiniFilesCursorLine = { bg = p.bg_selected }
  groups.MiniFilesTitle = { fg = p.yellow, bold = true }
  groups.MiniPickNormal = { fg = p.text, bg = p.surface }
  groups.MiniPickBorder = { fg = p.border, bg = p.surface }
  groups.MiniPickMatch = { fg = p.orange, bold = true }
  groups.MiniPickPrompt = { fg = p.green }
  groups.MiniPickCursorLine = { fg = p.text_strong, bg = p.bg_selected }
  groups.MiniStatuslineMode = { fg = p.bg, bg = p.green, bold = true }
  groups.MiniStatuslineNormal = { fg = p.text, bg = p.surface_alt }
  groups.MiniStatuslineInactive = { fg = p.text_faint, bg = p.surface_alt }

  -- Navigation and motion helpers
  groups.FlashLabel = { fg = p.bg, bg = p.yellow, bold = true }
  groups.FlashMatch = { fg = p.text_strong, bg = p.match }
  groups.FlashCurrent = { fg = p.bg, bg = p.orange }
  groups.FlashCursor = { bg = p.orange }
  groups.LeapLabelPrimary = { fg = p.bg, bg = p.orange, bold = true }
  groups.LeapLabelSecondary = { fg = p.bg, bg = p.aqua, bold = true }
  groups.LeapMatch = { bg = p.bg_selected, underline = true }
  groups.IlluminatedWordText = { bg = p.bg_selected }
  groups.IlluminatedWordRead = { bg = p.bg_selected }
  groups.IlluminatedWordWrite = { fg = p.text_strong, bg = p.bg_selected, bold = true }
  groups.TreesitterContext = { bg = p.bg_alt }
  groups.TreesitterContextLineNumber = { fg = p.text_faint, bg = p.bg_alt }
  groups.NavicText = { fg = p.text_muted }
  groups.NavicTextSeparator = { fg = p.text_faint }
  groups.NavicTextCurrent = { fg = p.yellow }

  -- Dropbar
  groups.DropbarMenuNormalFloat = { fg = p.text, bg = p.surface }
  groups.DropbarMenuFloatBorder = { fg = p.border, bg = p.surface }
  groups.DropbarMenuSelection = { fg = p.text_strong, bg = p.bg_selected }
  groups.DropbarMenuSeparator = { fg = p.text_faint }
  groups.DropbarMenuIcon = { fg = p.blue }
  groups.DropbarMenuFileIcon = { fg = p.blue }
  groups.DropbarCurrentContext = { fg = p.text, bg = p.bg_alt }
  groups.DropbarCurrentContextBorder = { fg = p.border, bg = p.bg_alt }

  -- Oil.nvim
  groups.OilNormal = { fg = p.text, bg = p.surface }
  groups.OilDir = { fg = p.blue }
  groups.OilFile = { fg = p.text }
  groups.OilHidden = { fg = p.text_faint }
  groups.OilDirIcon = { fg = p.blue }
  groups.OilFileIcon = { fg = p.text_muted }
  groups.OilLink = { fg = p.aqua }
  groups.OilSocket = { fg = p.purple }
  groups.OilExecutable = { fg = p.green }
  groups.OilCreate = { fg = p.green }
  groups.OilDelete = { fg = p.red }
  groups.OilMove = { fg = p.yellow }
  groups.OilCopy = { fg = p.aqua }
  groups.OilChange = { fg = p.orange }

  return groups
end

function M.get(p)
  return add_plugin_groups({}, p)
end

return M
