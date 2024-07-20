return {
  "Wansmer/treesj",
  event = "BufReadPre",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup {
      use_default_keymaps = false,
    }
  end,
  keys = {
    { "<leader>m", function() require("treesj").toggle() end, desc = "treesj - join/split" }
  },
}
