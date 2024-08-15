return {
  "petertriho/nvim-scrollbar",
  event = "BufReadPre",
  config = function()
    require("scrollbar").setup({
      hide_if_all_visible = true,
      handle = {
        blend = 0,
      },
      handlers = {
        gitsigns = true,
      },
      -- excluded_filetypes = {
      --   "minifiles",
      -- },
    })
  end,
}
