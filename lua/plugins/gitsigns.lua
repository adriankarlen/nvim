return {
  -- {
  --   "tpope/vim-fugitive",
  -- },
  {
    event = "BufReadPre",
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        signs = {
          delete = { text = "" },
        },
      }
    end,
  },
}
