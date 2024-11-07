local M = {}

function M.pick(kind)
  return function()
    local actions = require "CopilotChat.actions"
    local items = actions[kind .. "_actions"]()
    if not items then
      vim.notify("No " .. kind .. " found on the current line", 3)
      return
    end
    require("CopilotChat.actions").pick(items)
  end
end

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    cmd = "CopilotChat",
    opts = function()
      local user = vim.env.USER or ""
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = true,
        show_help = true,
        question_header = "  " .. user .. " ",
        answer_header = "  copilot ",
        window = {
          width = 0.4,
        },
        selection = function(source)
          local select = require "CopilotChat.select"
          return select.visual(source) or select.buffer(source)
        end,
      }
    end,
    keys = {
      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "submit", remap = true },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "toggle chat",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "clear chat",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          local input = vim.fn.input "quick chat: "
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end,
        desc = "quick chat",
        mode = { "n", "v" },
      },
      -- show help
      { "<leader>ad", M.pick "help", desc = "diagnostic help", mode = { "n", "v" } },
      -- show prompts actions
      { "<leader>ap", M.pick "prompt", desc = "prompt actions", mode = { "n", "v" } },
    },
    config = function(_, opts)
      local chat = require "CopilotChat"

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })
      chat.setup(opts)
    end,
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = "copilot-chat",
        title = "copilot chat",
        size = { width = 50 },
      })
    end,
  },
}
