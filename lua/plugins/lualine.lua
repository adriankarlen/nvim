return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      local lualine = require "lualine"
      local palette = require "rose-pine.palette"

      local mode_color = {
        n = palette.rose,
        no = palette.rose,

        i = palette.foam,
        ic = palette.foam,

        v = palette.iris,
        [""] = palette.iris,
        V = palette.iris,

        c = palette.love,
        cv = palette.love,
        ce = palette.love,
        ["!"] = palette.love,
        t = palette.love,

        s = palette.gold,
        S = palette.gold,
        [""] = palette.gold,

        r = palette.pine,
        rm = palette.pine,
        R = palette.pine,
        Rv = palette.pine,
        ["r?"] = palette.pine,
      }

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand "%:t") ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand "%:p:h"
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      -- Config
      local config = {
        options = {
          component_separators = "",
          section_separators = "",
          theme = {
            normal = {
              c = function()
                -- auto change color according to neovims mode
                return { fg = mode_color[vim.fn.mode()], bg = palette.surface }
              end,
            },
            inactive = { c = { fg = palette.subtle, bg = palette.surface } },
          },
          disabled_filetypes = {
            statusline = {
              "help",
              "lazy",
              "mason",
              "notify",
              "alpha",
              "dapui_scopes",
              "dapui_breakpoints",
              "dapui_stacks",
              "dapui_watches",
              "dapui_console",
              "dap-repl",
            },
          },
        },
        sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- These will be filled later
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }

      -- Inserts a component in lualine_c at left section
      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      -- Inserts a component in lualine_x at right section
      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end

      ins_left {
        function()
          return "▊"
        end,
        padding = { left = 0, right = 1 }, -- We don't need space before this
      }

      ins_left {
        -- mode component
        function()
          return ""
        end,
        padding = { right = 1 },
      }

      ins_left {
        function()
          local statusline = require "arrow.statusline"
          return statusline.text_for_statusline_with_icons()
        end,
        _separator = " ",
      }
      -- Insert mid section. You can make any number of sections in neovim :)
      -- for lualine it's any number greater then 2
      ins_left {
        function()
          return "%="
        end,
      }

      ins_left {
        -- Conform current formatter
        function()
          local msg = "No Active Formatter"
          local status, conform = pcall(require, "conform")
          if not status then
            return msg
          end

          local formatters = conform.list_formatters(0)
          if next(formatters) == nil then
            return msg
          end

          local formatter_names = {}
          for _, formatter in ipairs(formatters) do
            table.insert(formatter_names, formatter.name)
          end
          return table.concat(formatter_names, ", ")
        end,
        icon = "",
      }

      ins_left {
        -- Lsp server name .
        function()
          local msg = "No Active Lsp"
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = "󱌣",
        separator,
      }

      -- Add components to right sections
      ins_right {
        require("noice").api.statusline.mode.get,
        cond = require("noice").api.statusline.mode.has,
        color = { fg = palette.gold },
      }

      ins_right {
        "filetype",
        icons_enabled = false,
      }

      ins_right {
        "o:encoding",
        fmt = string.upper,
        cond = conditions.hide_in_width,
      }

      ins_right {
        "fileformat",
        fmt = string.upper,
        icons_enabled = false,
      }

      ins_right {
        "branch",
        icon = "",
      }

      ins_right {
        function()
          return "▊"
        end,
        padding = { left = 0 },
      }

      lualine.setup(config)
    end,
  },
}
