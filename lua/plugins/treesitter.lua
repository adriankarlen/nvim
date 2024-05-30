return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require "nvim-treesitter.configs"
    config.setup {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    }
    vim.treesitter.language.register("markdown", "mdx")
  end,
}
