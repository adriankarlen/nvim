return {
  "Chaitanyabsprip/fastaction.nvim",
  event = "VeryLazy",
  opts = {
    register_ui_select = true,
    popup = {
      border = "single",
      hide_cursor = true,
      highlight = {
        divider = "FloatBorder",
        key = "MoreMsg",
        title = "Title",
        window = "NormalFloat",
      },
      title = "Select:",
    },
  },
  keys = {
    {
      "<leader>ca",
      function()
        require("fastaction").code_action()
      end,
      desc = "fastaction - code action",
      buffer = true,
    },
  },
}
