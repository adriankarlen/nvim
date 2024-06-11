return {
  "MeanderingProgrammer/markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("render-markdown").setup {
      headings = { "○ ", "○ ", "○ ", "○ ", "○ ", "○ " },
      checkbox = {
        -- Character that will replace the [ ] in unchecked checkboxes
        unchecked = "󰄱 ",
        -- Character that will replace the [x] in checked checkboxes
        checked = " ",
      },
      file_types = { "markdown" },
    }
  end,
}
