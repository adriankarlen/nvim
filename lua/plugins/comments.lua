return {
  "numtostr/Comment.nvim",
  event = "BufRead",
  dependencies = "joosepalviste/nvim-ts-context-commentstring",
  config = function()
    require("Comment").setup {
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }
  end,
  keys = {
    {
      "<leader>/",
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      desc = "comment on current line",
    },
    {
      "<leader>/",
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      desc = "toggle comment on selected lines",
      mode = "v",
    },
  },
}
