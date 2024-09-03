return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "ColorScheme",
  cmd = "ToggleTerm",
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
  keys = function(_, keys)
    local function toggleterm()
      local venv = vim.b["virtual_env"]
      local term = require("toggleterm.terminal").Terminal:new {
        env = venv and { VIRTUAL_ENV = venv } or nil,
        count = vim.v.count > 0 and vim.v.count or 1,
      }
      term:toggle()
    end
    local mappings = {
      { "<leader><leader>", mode = { "n", "t" }, toggleterm, desc = "toggle terminal" },
    }
    return vim.list_extend(mappings, keys)
  end,
}
