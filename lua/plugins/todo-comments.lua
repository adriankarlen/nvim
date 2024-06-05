return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  event = "BufRead",
  keys = {
    { "<leader>fc", "<cmd>TodoTelescope<cr>", desc = "telescope - todo comments" },
  },
}
