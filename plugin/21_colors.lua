---@diagnostic disable: assign-type-mismatch
local add = vim.pack.add
local gh, now = Config.gh, Config.now

now(function()
  add { { src = gh "rose-pine/neovim", name = "rose-pine" } }
  ---@diagnostic disable-next-line: missing-fields, param-type-mismatch
  require("rose-pine").setup {
    highlight_groups = {
      Comment = { fg = "muted" },
      MiniStarterHeader = { fg = "love" },
      MiniInputPrompt = { bg = "surface" },
    },
  }
  vim.cmd.colorscheme "rose-pine"
end)
