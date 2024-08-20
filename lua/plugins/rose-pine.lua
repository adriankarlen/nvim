return {
  {
    "rose-pine/neovim",
    lazy = false,
    name = "rose-pine",

    config = function()
      require("rose-pine").setup {
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
        },
      }
      vim.cmd "colorscheme rose-pine"
    end,
  },
}
