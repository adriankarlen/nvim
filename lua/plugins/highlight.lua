return {
  "brenoprata10/nvim-highlight-colors",
  config = function()
    require("nvim-highlight-colors").setup {
      render = "virtual",
      virtual_symbol = "",
      enable_tailwind = true,
      enable_named_colors = false,
    }
  end,
}
