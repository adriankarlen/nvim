return {
  "OXY2DEV/markview.nvim",
  enabled = false,
  filetypes = { "markdown", "rmd", "org" },
  config = function()
    require("markview").setup()
  end,
}
