return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enable = false,
      },
      panel = {
        enable = false,
      },
    },
  },
  {
    "yetone/avante.nvim",
    opts = {
      provider = "claude",
      windows = {
        sidebar_header = {
          align = "left",
          rounded = false,
        },
      },
    },
    dependencies = {
      "echasnovski/mini.icons",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "HakonHarnes/img-clip.nvim",
    },
  },
}
