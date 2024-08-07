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
      -- groups
      { "<leader>a", group = "ai" },
      { "<leader>b", group = "buffer" },
      { "<leader>c", group = "code" },
      { "<leader>d", group = "debug" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>h", group = "hurl", icon = "" },
      { "<leader>l", group = "lsp" },
      { "<leader>p", group = "packages", icon = "" },
      { "<leader>pn", group = "dotnet", icon = "󰌛" },
      { "<leader>r", group = "compiler", icon = "" },
      { "<leader>t", group = "toggle" },
      { "<leader>x", group = "diagnostics" },
      -- commands
      { "<leader>bd", icon = "󰭿" },
      { "<leader>bD", icon = "󰭿" },
      { "<leader>ca", icon = "󱐋" },
      { "<leader>cb", icon = "󰅺" },
      { "<leader>cf", icon = "" },
      { "<leader>cm", icon = "󱓡" },
      { "<leader>cr", icon = "󰏪" },
      { "<leader>ct", icon = "󰅺" },
      { "<leader>db", icon = "󰃤" },
      { "<leader>e", icon = "󰙅" },
      { "<leader>/", icon = "󰅺" },
    },
    disable = {
      ft = {
        "lazygit",
        "toggleterm",
      },
    },
  },
}
