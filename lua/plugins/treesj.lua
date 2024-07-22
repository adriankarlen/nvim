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
    { "<leader>cm", function() require("treesj").toggle() end, desc = "join/split block" }
  },
}
