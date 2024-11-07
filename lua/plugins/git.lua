return {
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
    opts = {},
    keys = {
      { "<leader>gD", "<cmd>DiffviewOpen<cr>"}
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    cmd = "Gitsigns",
    ft = { "gitcommit", "diff" },
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.jobstart({"git", "-C", vim.loop.cwd(), "rev-parse"},
            {
              on_exit = function(_, return_code)
                if return_code == 0 then
                  vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                  vim.schedule(function()
                    require("lazy").load { plugins = { "gitsigns.nvim" } }
                  end)
                end
              end
            }
          )
        end,
      })
    end,
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
