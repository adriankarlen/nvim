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
          TelescopeBorder = { fg = "highlight_med", bg = "none" },
          TelescopeNormal = { bg = "none" },
          TelescopePromptNormal = { bg = "none" },
          TelescopeResultsNormal = { fg = "subtle", bg = "none" },
          TelescopeSelection = { fg = "text", bg = "none" },
          TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
          FloatBorder = { fg = "highlight_med", bg = "none" },
          NormalFloat = { fg = "text", bg = "none" },
          MiniTablineModifiedCurrent = { fg = "gold", bg = "gold", blend = 15, bold = true },
          MiniTablineModifiedVisible = { fg = "gold", bg = "gold", blend = 15 },
          MiniTablineModifiedHidden = { fg = "subtle", bg = "gold", blend = 15 },
          DapUIPlayPause = { fg = "pine" },
          DapUIStop = { fg = "love" },
          DapUIStepInto = { fg = "foam" },
          DapUIStepOver = { link = "DapUiStepInto" },
          DapUIStepOut = { link = "DapUiStepInto" },
          DapUIStepBack = { link = "DapUiStepInto" },
          DapUIRestart = { link = "DapUIPlayPause" },
          DapUIStepIntoNC = { fg = "muted", bg = "none" },
          DapUIStepOverNC = { link = "DapUiStepIntoNC" },
          DapUIStepOutNC = { link = "DapUiStepIntoNC" },
          DapUIStepBackNC = { link = "DapUiStepIntoNC" },
          DapUIStopNC = { link = "DapUiStepIntoNC" },
        },
      }
      vim.cmd "colorscheme rose-pine"
    end,
  },
  {
    "rachartier/tiny-devicons-auto-colors.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
      local palette = require "rose-pine.palette"
      require("tiny-devicons-auto-colors").setup {
        colors = palette,
      }
    end,
  },
}
