return {
  "ravibrock/spellwarn.nvim",
  event = "BufEnter",
  config = true,

  keys = {
    {
      "<leader>Ts",
      function()
        require("spellwarn").toggle()
      end,
      noremap = true,
      silent = true,
      desc = "spellwarn",
    },
  },
}
