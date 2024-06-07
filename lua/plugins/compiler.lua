return {
  {
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
    opts = {},
    keys = {
      { "<F6>", "<cmd>CompilerOpen<CR>", noremap = true, silent = true, desc = "compiler - open" },
      {
        "<S-F6>",
        "<cmd>CompilerStop<cr>" .. "<cmd>CompilerRedo<CR>",
        noremap = true,
        silent = true,
        desc = "compiler - redo",
      },
      { "<S-F7>", "<cmd>CompilerToggleResults<CR>", noremap = true, silent = true, desc = "compiler - toggle results" },
    },
  },
  {
    "stevearc/overseer.nvim",
    commit = "68a2d344cea4a2e11acfb5690dc8ecd1a1ec0ce0",
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
