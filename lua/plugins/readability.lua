return {
  {
    "folke/twilight.nvim",
    event = "BufReadPre",
    opts = {
      dimming = {
        alpha = 0.15,
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    event = "BufReadPre",
    opts = {
      wezterm = {
        enabled = true,
        font_size = "+4",
      },
    },
    keys = {
      "<Leader>z",
    },
  },
}
