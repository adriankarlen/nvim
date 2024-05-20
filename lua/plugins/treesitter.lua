return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "windwp/nvim-ts-autotag" },
    },
    opts = {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      autopairs = { enable = true },
      autotag = { enable = true },
    },
  },
}
