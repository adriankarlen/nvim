return {
  "mistweaverco/kulala.nvim",
  ft = { "json", "http" },
  config = function()
    require("kulala").setup {
      icons = {
        inlay = {
          loading = "󰔟 ",
          done = "󰄬 ",
        },
        lualine = "󰏚",
      },
    }
  end,
}
