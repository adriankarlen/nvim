return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
  keys = {
    {
      "<leader>yy",
      function()
        require("yazi").yazi(nil, vim.fn.getcwd())
      end,
      desc = "yazy open",
    },
  },
  opts = {
    open_for_directories = false,
    floating_window_scaling_factor = 0.6,
  },
}
