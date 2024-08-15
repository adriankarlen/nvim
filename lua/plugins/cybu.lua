return {
  "ghillb/cybu.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "echasnovski/mini.icons",
  },
  config = function()
    require("cybu").setup {
      behavior = {
        mode = {
          last_used = {
            switch = "immediate",
            view = "rolling",
          },
        },
        display_time = 250,
      },
    }
  end,
  keys = {

    {
      "<tab>",
      function()
        require("cybu").cycle "next"
      end,
      mode = { "n", "v" },
      desc = "cybu - next",
    },
    {
      "<s-tab>",
      function()
        require("cybu").cycle "prev"
      end,
      mode = { "n", "v" },
      desc = "cybu - prev",
    },
  },
  event = "BufRead",
}
