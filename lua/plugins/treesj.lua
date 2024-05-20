return {
  "Wansmer/treesj",
  event = "BufReadPre",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup {--[[ your config ]]
    }
  end,
  keys = { "<leader>m", "<leader>j", "<leader>s" },
}
