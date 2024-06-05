return {
  "adriankarlen/modes.nvim",
  event = "BufReadPre",
  config = function()
    local palette = require "rose-pine.palette"
    require("modes").setup {
      colors = {
        bg = palette.base,
      },
    }
    vim.opt.guicursor:append "n-c:Cursor"
  end,
}
