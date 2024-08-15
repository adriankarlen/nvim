return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "echasnovski/mini.icons",
  },
  event = "BufWinEnter",
  config = function()
    local palette = require "rose-pine.palette"
    -- triggers CursorHold event faster
    vim.opt.updatetime = 200

    require("barbecue").setup {
      create_autocmd = false, -- prevent barbecue from updating itself automatically
      theme = {
        normal = { fg = palette.subtle },
      },
      symbols = {
        separator = "->",
      },
    }

    vim.api.nvim_create_autocmd({
      "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
      "BufWinEnter",
      "CursorHold",
      "InsertLeave",

      -- include this if you have set `show_modified` to `true`
      "BufModifiedSet",
    }, {
      group = vim.api.nvim_create_augroup("barbecue.updater", {}),
      callback = function()
        require("barbecue.ui").update()
      end,
    })
  end,
}
