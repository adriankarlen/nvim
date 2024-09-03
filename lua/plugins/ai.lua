return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enable = false,
      },
      panel = {
        enable = false,
      },
    },
  },
  {
    "yetone/avante.nvim",
    dependencies = {
      "echasnovski/mini.icons",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "HakonHarnes/img-clip.nvim",
      "zbirenbaum/copilot.lua",
    },
    opts = {
      provider = "copilot",
      windows = {
        sidebar_header = {
          rounded = false,
        },
      },
    },
    keys = {
      -- stylua: ignore start
      { "<leader>aa", function() require("avante.api").ask() end, desc = "ask", mode = { "n", "v" } },
      { "<leader>ar", function() require("avante.api").refresh() end, desc = "refresh" },
      { "<leader>ae", function() require("avante.api").edit() end, desc = "edit", mode = "v" },
      -- stylua: ignore end
    },
  },
  -- {
  --   "olimorris/codecompanion.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-telescope/telescope.nvim", -- Optional
  --   },
  --   opts = {
  --     strategies = {
  --       inline = {
  --         adapter = "copilot",
  --       },
  --       chat = {
  --         adapter = "copilot",
  --       },
  --       agent = {
  --         adapter = "copilot",
  --       },
  --     },
  --   },
  --   keys = {
  --     -- stylua: ignore start
  --     { "<leader>aq", function() local q = vim.fn.input "Ask: " if q ~= "" then vim.cmd("CodeCompanion " .. q) end end, desc = "ask" },
  --     { "<leader>aa", "<cmd>CodeCompanionToggle<cr>", desc = "open" },
  --
  --     -- stylua: ignore end
  --   },
  -- },
}
