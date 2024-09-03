return {
  "chrishrb/gx.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "Browse" },
  init = function()
    vim.g.netrw_nogx = 1
  end,
  submodules = false,
  opts = {
    handlers = {
      jira = {
        name = "jira",
        handle = function(mode, line, _)
          local ticket = require("gx.helper").find(line, mode, "(%u+-%d+)")
          if ticket and #ticket < 20 then
            return "http://jira.storebrand.no/browse/" .. ticket
          end
        end,
      },
    },
    handler_options = {
      search_engine = "https://search.brave.com/search?q=",
      select_for_search = false,
      git_remotes = { "upstream", "origin" },
      git_remote_push = true,
    },
  },
  keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
}
