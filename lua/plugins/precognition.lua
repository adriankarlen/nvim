return {
  "tris203/precognition.nvim",
  event = "BufRead",
  keys = {
    {
      "<leader>H",
      function()
        require("precognition").toggle()
      end,
      desc = "toggle movement hints",
    },
  },
}
