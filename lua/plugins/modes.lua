return {
  "mvllow/modes.nvim",
  event = "BufReadPre",
  config = function()
    require("modes").setup {}
  end,
}
