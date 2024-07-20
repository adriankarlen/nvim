return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    preset = "modern",
    win = { border = "single" },
    spec = {
      { "<leader>a", group = "ai" },
      { "<leader>b", group = "buffer" },
      { "<leader>c", group = "code" },
      { "<leader>d", group = "debug" },
      { "<leader>e", icon = "󰙅" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>l", group = "lsp" },
      { "<leader>m", icon = "󱓡" },
      { "<leader>p", group = "packages", icon = "" },
      { "<leader>t", group = "toggle" },
      { "<leader>x", group = "diagnostics" },
      { "<leader>/", icon = "󰆂" }
    },
    disable = {
      ft = { "lazygit" }
    }
  },
}
