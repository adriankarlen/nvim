return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    event = "BufReadPre",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      window = {
        layout = "float",
        width = 0.8,
        height = 0.5,
        row = 5,
      },
      selection = function(source)
        local select = require "CopilotChat.select"
        return select.visual(source) or select.buffer(source)
      end,
    },
    config = function(_, opts)
      local chat = require "CopilotChat"
      chat.setup(opts)
    end,
    keys = {
      -- open chat window without asking question
      {
        "<leader>cco",
        function()
          require("CopilotChat").open()
        end,
        mode = { "n", "v" },
        desc = "copilot chat - open chat window",
      },
      -- select a predefined prompt
      {
        "<leader>ccp",
        function()
          local actions = require "CopilotChat.actions"
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        mode = { "n", "v" },
        desc = "copilot chat - select a prompt",
      },
      -- code related prompts
      {
        "<leader>cce",
        "<cmd>CopilotChatExplain<cr>",
        mode = { "n", "v" },
        desc = "copilot chat - Explain code",
      },
      {
        "<leader>cct",
        "<cmd>CopilotChatTests<cr>",
        mode = { "n", "v" },
        desc = "copilot chat - generate tests",
      },
      {
        "<leader>ccr",
        "<cmd>CopilotChatReview<cr>",
        mode = { "n", "v" },
        desc = "copilot chat - review code",
      },
      {
        "<leader>ccR",
        "<cmd>CopilotChatRefactor<cr>",
        mode = { "n", "v" },
        desc = "copilot chat - refactor code",
      },
      {
        "<leader>ccn",
        "<cmd>CopilotChatBetterNamings<cr>",
        mode = { "n", "v" },
        desc = "copilot chat - better Naming",
      },
      -- commit related prompts
      {
        "<leader>ccm",
        "<cmd>CopilotChatCommit<cr>",
        desc = "copilot chat - generate commit message for all changes",
      },
      {
        "<leader>ccM",
        "<cmd>CopilotChatCommitStaged<cr>",
        desc = "copilot chat - generate commit message for staged changes",
      },
      -- open chat and ask for custom prompt
      {
        "<leader>ccq",
        function()
          local input = vim.fn.input "question: "
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end,
        mode = { "n", "v" },
        desc = "copilot chat - quick chat",
      },
      -- reset chat
      {
        "<leader>ccx",
        function()
          require("CopilotChat").reset()
        end,
        mode = { "n", "v" },
        desc = "copilot chat - reset chat",
      },
    },
  },
}
