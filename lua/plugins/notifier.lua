return {
  "vigoux/notifier.nvim",
  config = function()
    require("notifier").setup {
      components = {
        "nvim",
      },
    }
  end,
}
