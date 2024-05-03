return {
  -- Show all todo comments in solution
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  -- HACK: Add setup function
  event = "BufRead",
  keys = {
    { "<leader>fc", "<cmd>TodoTelescope<cr>", "telescope todo comments" },
  },
}
