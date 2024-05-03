return {
  "numtostr/Comment.nvim",
  event = "BufRead",
  dependencies = "joosepalviste/nvim-ts-context-commentstring",
  config = function()
    require("Comment").setup {
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }
  end,
}
