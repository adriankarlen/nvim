return {
  "rose-pine/neovim",
  lazy = false,
  name = "rose-pine",
  config = function()
    require("rose-pine").setup {
      highlight_groups = {
        MatchParen = { fg = "love", bg = "love", blend = 25 },
        TelescopeBorder = { fg = "highlight_high", bg = "none" },
        TelescopeNormal = { bg = "none" },
        TelescopePromptNormal = { bg = "base" },
        TelescopeResultsNormal = { fg = "subtle", bg = "none" },
        TelescopeSelection = { fg = "text", bg = "base" },
        TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
        FloatBorder = { fg = "highlight_high", bg = "none" },
        NormalFloat = { fg = "text", bg = "none" },
      },
    }
    vim.cmd "colorscheme rose-pine"
  end,
}
