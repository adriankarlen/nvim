return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd [[do FileType]]
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    ft = "markdown, codecompanion",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.icons",
    },
    opts = function()
      local palette = require "rose-pine/palette"
      local opts = {
        code_blocks = {
          hl = "CursorLine",
          sign_hl = nil,
        },
        highlight_groups = {
          { group_name = "Heading1", value = { fg = palette.base, bg = palette.iris } },
          { group_name = "Heading1Corner", value = { fg = palette.iris } },
          { group_name = "Heading1Sign", value = { fg = palette.iris } },
          { group_name = "Heading2", value = { fg = palette.base, bg = palette.foam } },
          { group_name = "Heading2Corner", value = { fg = palette.foam } },
          { group_name = "Heading2Sign", value = { fg = palette.foam } },
          { group_name = "Heading3", value = { fg = palette.base, bg = palette.rose } },
          { group_name = "Heading3Corner", value = { fg = palette.rose } },
          { group_name = "Heading3Sign", value = { fg = palette.rose } },
          { group_name = "Heading4", value = { fg = palette.base, bg = palette.gold } },
          { group_name = "Heading4Corner", value = { fg = palette.gold } },
          { group_name = "Heading4Sign", value = { fg = palette.gold } },
          { group_name = "Heading5", value = { fg = palette.base, bg = palette.pine } },
          { group_name = "Heading5Corner", value = { fg = palette.pine } },
          { group_name = "Heading5Sign", value = { fg = palette.pine } },
          { group_name = "Heading6", value = { fg = palette.base, bg = palette.leaf } },
          { group_name = "Heading6Corner", value = { fg = palette.leaf } },
          { group_name = "Heading6Sign", value = { fg = palette.leaf } },
        },
        headings = require("markview.presets").headings.decorated_labels,
        html = {
          enabled = true,
        },
        inline_codes = {
          hl = "CursorLine",
        },
        list_items = {
          marker_plus = {
            text = "⯁",
          },
          marker_minus = {
            text = "",
          },
          marker_star = {
            text = "⬣",
          },
        },
        tables = {
        -- stylua: ignore start
        text = {
          "┌", "─", "┐", "┬",
          "├", "│", "┤", "┼",
          "└", "─", "┘", "┴",
          "╼", "╾", "╴", "╶"
        },
          -- stylua: ignore end
        },
      }
      vim.cmd "Markview enableAll"
      return opts
    end,
  },
}
