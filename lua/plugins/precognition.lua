return {
  "tris203/precognition.nvim",
  event = "BufRead",
  keys = {
    {
      "<leader>Tp",
      function()
        require("precognition").toggle()
      end,
      desc = "precognition",
    },
  },
}
