return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
  opts = {
    file_types = { "markdown", "copilot-chat" },
    code = {
      width = "block",
      right_pad = 1,
    },
    heading = {
      sign = false,
      icons = { "󰉫 ", "󰉬  ", "󰉭   ", "󰉮    ", "󰉯     ", "󰉰      " },
    },
  },
  ft = { "markdown", "copilot-chat" },
}
