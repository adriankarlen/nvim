return {
  "MeanderingProgrammer/markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("render-markdown").setup {
      headings = { "○ ", "○ ", "○ ", "○ ", "○ ", "○ " },
      checkbox = {
        unchecked = "󰄱 ",
        checked = " ",
      },
      file_types = { "markdown" },
      win_options = {
        concealcursor = "vic"
      },
    }
  end,
}
