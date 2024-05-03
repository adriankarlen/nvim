return {
  -- Enables jj and jk commands to exit insert mode
  "max397574/better-escape.nvim",
  config = function()
    require("better_escape").setup()
  end,
  event = "InsertEnter",
}
