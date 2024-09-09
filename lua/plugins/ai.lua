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
  -- {
  --   "yetone/avante.nvim",
  --   lazy = false,
  --   version = false,
  --   dependencies = {
  --     "echasnovski/mini.icons",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     "HakonHarnes/img-clip.nvim",
  --   },
  --   opts = {
  --     provider = "copilot",
  --     windows = {
  --       sidebar_header = {
  --         rounded = false,
  --       },
  --     },
  --   },
  --   keys = {
  --     -- stylua: ignore start
  --     { "<leader>aa", function() require("avante.api").ask() end, desc = "ask", mode = { "n", "v" } },
  --     { "<leader>ar", function() require("avante.api").refresh() end, desc = "refresh" },
  --     { "<leader>ae", function() require("avante.api").edit() end, desc = "edit", mode = "v" },
  --     -- stylua: ignore end
  --   },
  -- },
  {
    "olimorris/codecompanion.nvim",
    event = "BufEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- Optional
    },
    opts = {
      strategies = {
        inline = {
          adapter = "copilot",
        },
        chat = {
          adapter = "copilot",
          roles = {
            llm = "  Copilot",
          },
        },
        agent = {
          adapter = "copilot",
        },
      },
      display = {
        chat = {
          window = {
            layout = "float",
          },
        },
      },
    },
    keys = {
      -- stylua: ignore start
      { "<leader>aq", function() local q = vim.fn.input "Ask: " if q ~= "" then vim.cmd("CodeCompanion " .. q) end end, desc = "quick ask" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "x" }, desc = "actions" },
      { "<leader>at", "<cmd>CodeCompanionToggle<cr>", mode = { "n", "x" }, desc = "toggle" },
      -- stylua: ignore end
    },
  },
}
