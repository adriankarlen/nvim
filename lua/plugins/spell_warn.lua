return {
  "ravibrock/spellwarn.nvim",
  event = "BufEnter",
  config = true,

  keys = {
    {
      "<leader>ts",
      function()
        require("spellwarn").toggle()
      end,
      {
        noremap = true,
        silent = true,
        desc = "spellwarn",
      },
    },
  },
}
