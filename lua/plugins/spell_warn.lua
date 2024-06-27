return {
  "ravibrock/spellwarn.nvim",
  event = "BufEnter",
  config = true,

  keys = {
    {
      "<leader>sw",
      function()
        require("spellwarn").toggle()
      end,
      {
        noremap = true,
        silent = true,
        description = "spellwarn - toggle",
      },
    },
  },
}
