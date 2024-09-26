return {
  {
    "tpope/vim-fugitive",
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
    opts = {},
  },
  {
    "lewis6991/gitsigns.nvim",
    cmd = "Gitsigns",
    config = function()
      require("gitsigns").setup()
      require("scrollbar.handlers.gitsigns").setup()
    end,
    keys = {
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "preview hunk" },
      { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "stage hunk" },
      { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "reset hunk" },
      { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "undo stage hunk" },
      { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "blame line" },
      { "<leader>gd", "<cmd>Gitsigns toggle_deleted<cr>", desc = "toggle deleted" },
    },
  },
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
  {
    "chrisgrieser/nvim-tinygit",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      staging = {
        stagedIndicator = "+",
      },
      commitMsg = {
        spellcheck = true,
        conventionalCommits = {
          enforce = true,
        },
      },
    },
    keys = {
      -- stylua: ignore start
      { "<leader>ga", function() require("tinygit").interactiveStaging() end, desc = "stage" },
      { "<leader>gc", function() require("tinygit").smartCommit() end, desc = "commit" },
      { "<leader>gp", function() require("tinygit").push() end, desc = "push" },
      { "<leader>gP", function() require("tinygit").createGitHubPr() end, desc = "create pr" },
      -- stylua: ignore end
    },
  },
}
