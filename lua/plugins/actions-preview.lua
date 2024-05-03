return {
  "aznhe21/actions-preview.nvim",
  config = function()
    require("actions-preview").setup()
  end,
  keys = {
    {
      "<leader>ca",
      function ()
        require("actions-preview").code_actions()
      end,
      mode = { "v", "n" },
      desc = "code actions",
    },
  },
}
