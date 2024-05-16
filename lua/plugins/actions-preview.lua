return {
  "aznhe21/actions-preview.nvim",
  config = function()
    require("actions-preview").setup {
      telescope = {
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
          width = 0.4,
          height = 0.5,
          prompt_position = "top",
          preview_cutoff = 20,
          preview_height = function(_, _, max_lines)
            return max_lines - 15
          end,
        },
      },
    }
  end,

  keys = {
    {
      "<leader>ca",
      function()
        require("actions-preview").code_actions()
      end,
      mode = { "v", "n" },
      desc = "code actions for line",
    },
    {
      "<leader>cA",
      function()
        require("actions-preview").code_actions { context = { only = { "source" } } }
      end,
      mode = { "v", "n" },
      desc = "code actions for buffer",
    },
  },
}
