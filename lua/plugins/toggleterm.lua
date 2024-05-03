return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "ColorScheme",
  config = function()
    local highlights = require "rose-pine.plugins.toggleterm"
    require("toggleterm").setup {
      highlights = highlights,
      direction = "float",
      float_opts = {
        width = function()
          return math.ceil(vim.o.columns * 0.5)
        end,
        height = function()
          return math.ceil(vim.o.lines * 0.5)
        end,
        winblend = 3,
      },
    }
  end,
  keys = {
    { "<leader><leader>", "<cmd>ToggleTerm<cr>", mode = "n", desc = "toggle terminal" },
    { "<leader><leader>", "<C-\\><C-n><C-w>l", mode = "t", desc = "hide terminal" },
  },
}
