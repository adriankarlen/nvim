return {
  {
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
    opts = {},
    keys = {
      { "<leader>ro", "<cmd>CompilerOpen<cr>", noremap = true, silent = true, desc = "compiler - open" },
      {
        "<leader>rx",
        "<cmd>CompilerStop<cr>" .. "<cmd>CompilerRedo<CR>",
        noremap = true,
        silent = true,
        desc = "compiler - redo",
      },
      { "<leader>rt", "<cmd>CompilerToggleResults<CR>", noremap = true, silent = true, desc = "compiler - toggle results" },
    },
  },
  {
    "stevearc/overseer.nvim",
    commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
  },
}
