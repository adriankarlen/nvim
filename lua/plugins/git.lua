-- autocmd that only loads git plugins if within a git repo
vim.api.nvim_create_autocmd({ "BufRead" }, {
  group = vim.api.nvim_create_augroup("LazyLoadGitPlugins", { clear = true }),
  callback = function()
    vim.fn.jobstart({ "git", "-C", vim.loop.cwd(), "rev-parse" }, {
      on_exit = function(_, return_code)
        if return_code == 0 then
          vim.api.nvim_del_augroup_by_name "LazyLoadGitPlugins"
          vim.schedule(function()
            require("lazy").load { plugins = { "gitsigns.nvim", "git-conflict.nvim" } }
          end)
        end
      end,
    })
  end,
})

return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    ft = { "gitcommit", "diff" },
    opts = {},
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
    "akinsho/git-conflict.nvim",
    lazy = true,
    version = "*",
    opts = {},
  },
}
