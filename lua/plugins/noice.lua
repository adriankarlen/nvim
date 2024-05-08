return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    cmdline = {
      format = {
        search_down = {
          view = "cmdline",
        },
        search_up = {
          view = "cmdline",
        },
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}
