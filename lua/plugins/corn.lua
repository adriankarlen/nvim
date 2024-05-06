return {
  "RaafatTurki/corn.nvim",
  event = "BufRead",
  config = function()
    local corn = require "corn"
    corn.setup {
      icons = {
        error = ">",
        warn = ">",
        info = ">",
        hint = ">",
      },
      -- toggle virtual_text diags when corn is toggled
      on_toggle = function(is_hidden)
        if is_hidden then
          vim.diagnostic.config { virtual_text = false }
          return
        end
        vim.diagnostic.config { virtual_text = { prefix = ">" } }
      end,
    }
    -- start disabled atm.
    corn.toggle(false)
  end,
  keys = {
    {
      "<leader>ct",
      function()
        require("corn").toggle()
      end,
      desc = "toggle corn style diagnostics ",
    },
  },
}
