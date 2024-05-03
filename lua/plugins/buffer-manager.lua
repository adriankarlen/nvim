return {
  "j-morano/buffer_manager.nvim",
  config = function()
    require("buffer_manager").setup {
      short_file_names = true,
      short_term_names = true,
      highlight = "Normal:FloatBorder",
      -- win_extra_options = {
      --   winhighlight = "Normal:BufferManagerNormal",
      -- },
    }
  end,
  keys = {
    {
      "<leader>fb",
      function()
        require("buffer_manager.ui").toggle_quick_menu()
      end,
      desc = { "view buffers" },
    },
  },
}
