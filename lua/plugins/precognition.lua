return {
  "tris203/precognition.nvim",
  event = "BufRead",
  keys = {
    {
      "<leader>tH",
      function()
        require("precognition").toggle()
      end,
      desc = "precognition",
    },
  },
}
