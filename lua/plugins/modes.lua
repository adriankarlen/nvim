return {
  "mvllow/modes.nvim",
  event = "BufReadPre",
  config = function()
    local palette = require "rose-pine.palette"
    require("modes").setup {
      set_cursor = false,
      colors = {
        bg = palette.base,
      },
    }
    vim.opt.guicursor:append "n-c:Cursor"
  end,
}
