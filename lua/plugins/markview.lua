return {
  "OXY2DEV/markview.nvim",
  filetypes = { "markdown", "rmd", "org" },
  config = function()
    require("markview").setup()
  end,
}
