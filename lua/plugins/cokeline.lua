return {
  "willothy/nvim-cokeline",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for v0.4.0+
    "echasnovski/mini.icons",
  },

  config = function()
    local cokeline = require "cokeline"
    local get_hex = require("cokeline.hlgroups").get_hl_attr
    local components = {
      filename = {
        text = function(buf)
          return " " .. buf.filename .. " "
        end,
      },
      modified = {
        text = function(buf)
          return buf.is_modified and " " or "  "
        end,
        fg = function(buf)
          return buf.is_modified and get_hex("DiagnosticWarn", "fg") or get_hex("Normal", "fg")
        end,
      },
    }
    cokeline.setup {
      show_if_buffers_are_at_least = 1,
      buffers = {
        filter_valid = function(buf)
          return buf.is_modified
        end,
      },
      components = {
        components.filename,
        components.modified,
      },
    }
  end,
}
