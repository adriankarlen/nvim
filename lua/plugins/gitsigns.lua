return {
  {
    event = "BufReadPre",
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        signs = {
          delete = { text = "" },
        },
      }
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
}
