return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "windwp/nvim-ts-autotag" },
    },
    build = ":TSUpdate",
    config = function()
      local config = require "nvim-treesitter.configs"
      config.setup {
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        autopairs = { enable = true },
        autotag = { enable = true },
      }

      local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
      ft_to_parser.mdx = "markdown"
    end,
  },
}
