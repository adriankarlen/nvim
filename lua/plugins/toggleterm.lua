return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "ColorScheme",
  config = function()
    local highlights = require "rose-pine.plugins.toggleterm"
    require("toggleterm").setup {
      highlights = highlights,
      direction = "float",
      shade_terminals = false,
      float_opts = {
        width = function()
          return math.ceil(vim.o.columns * 0.5)
        end,
        height = function()
          return math.ceil(vim.o.lines * 0.5)
        end,
        winblend = 0,
      },
    }
  end,
  keys = {
    {
      "<leader><leader>",
      function()
        if vim.bo.filetype ~= "lazygit" then
          vim.cmd "ToggleTerm"
        end
      end,
      desc = "toggle terminal",
    },
    {
      "<leader><leader>",
      function()
        if vim.bo.filetype ~= "lazygit" then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n><C-w>l", true, true, true), "n", {})
        end
      end,
      mode = "t",
      desc = "hide terminal",
    },
  },
}
