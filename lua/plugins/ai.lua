return {
  {
    "olimorris/codecompanion.nvim",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
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
            width = 0.25,
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
