return {
  {
    "rose-pine/neovim",
    lazy = false,
    name = "rose-pine",
    config = function()
      require("rose-pine").setup {
        dark_variant = "moon",
        styles = {
          transparency = true,
        },
        highlight_groups = {
          MatchParen = { fg = "love", bg = "love", blend = 25 },
          StatuslineTextMain = { fg = "text" },
          StatuslineTextBold = { link = "StatuslineTextMain", bold = true },
          StatuslineTextAccent = { fg = "muted" },
          StatuslineModeCommand = { fg = "love", bold = true },
          StatuslineModeInsert = { fg = "foam", bold = true },
          StatuslineModeNormal = { fg = "rose", bold = true },
          StatuslineModeOther = { fg = "rose", bold = true },
          StatuslineModeReplace = { fg = "pine", bold = true },
          StatuslineModeVisual = { fg = "iris", bold = true },
          StatuslineNotSaved = { fg = "gold" },
          StatuslineReadOnly = { fg = "love" },
          StatuslineLspOn = { fg = "pine" },
          StatuslineFormatterStatus = { fg = "foam" },
          StatuslineCopilot = { fg = "rose" },
          QuickFixFilename = { fg = "text" },
          NoiceCmdlinePopupBorder = { fg = "rose" },
          NoiceCmdlinePopupTitle = { link = "NoiceCmdlinePopupBorder" },
          NoiceCmdlineIcon = { link = "NoiceCmdlinePopupBorder" },
          NoiceMini = { fg = "muted" },
          AvanteTitle = { fg = "rose", bg = "none" },
          AvanteSubtitle = { fg = "pine", bg = "none" },
          AvanteThirdTitle = { fg = "iris", bg = "none" },
          CodeCompanionChatHeader = { fg = "rose" },
          CodeCompanionChatSeparator = { fg = "muted" },
          CodeCompanionChatTokens = { fg = "gold" },
          CodeCompanionChatTool = { fg = "pine" },
          CodeCompanionChatVariable = { fg = "base", bg = "iris" },
          CodeCompanionVirtualText = { fg = "iris" },
          DapUIStepOver = { fg = "foam" },
          DapUIStepInto = { fg = "foam" },
          DapUIStepBack = { fg = "foam" },
          DapUIStepOut = { fg = "foam" },
          DapUIStop = { fg = "love" },
          DapUIPlayPause = { fg = "pine" },
          DapUIRestart = { fg = "pine" },
          DapUIUnavailable = { fg = "muted" },
          IndentLineCurrent = { fg = "muted" },
          EasyDotnetTestRunnerSolution = { fg = "pine" },
          EasyDotnetTestRunnerProject = { fg = "rose" },
          EasyDotnetTestRunnerTest = { fg = "iris" },
          DiagnosticUnderlineError = { bg = "love", blend = 20 },
          DiagnosticUnderlineHint = { bg = "iris", blend = 20 },
          DiagnosticUnderlineInfo = { bg = "foam", blend = 20 },
          DiagnosticUnderlineOk = { bg = "leaf", blend = 20 },
          DiagnosticUnderlineWarn = { bg = "gold", blend = 20 },
          DashboardDesc = { fg = "iris" },
          DashboardFiles = { fg = "iris" },
          DashboardFooter = { fg = "muted", italic = true },
          DashboardHeader = { fg = "pine" },
          DashboardIcon = { fg = "subtle" },
          DashboardKey = { fg = "gold" },
          DashboardMruIcon = { link = "DashboardIcon"},
          DashboardMruTitle = { fg = "iris" },
          DashboardProjectIcon = { link = "DashboardIcon" },
          DashboardProjectTitle = { fg = "foam" },
          DashboardShortcut = { fg = "gold" },
          DashboardShortcutIcon = { link = "DashboardIcon" },
        },
      }
      vim.cmd "colorscheme rose-pine"
    end,
  },
}
