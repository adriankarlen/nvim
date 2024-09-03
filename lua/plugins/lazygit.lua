return {
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.g.lazygit_floating_window_border_chars = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
    end,
    keys = {
      { "<leader>gl", "<cmd>LazyGit<cr>", desc = "lazygit" },
    },
  },
}
