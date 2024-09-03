return {
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    tag = "v4.4.7",
    event = "VeryLazy",
    opts = {
      lsp = {
        progress = { enabled = false },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      notify = { enabled = false },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
      views = {
        mini = {
          position = {
            col = -2,
            row = -2,
          },
          win_options = {
            winblend = 0,
          },
          border = {
            style = "single",
          },
        },
        cmdline_popup = {
          border = {
            style = "single",
          },
        },
      },
    },
  },
}
