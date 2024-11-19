return {
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = { "SmiteshP/nvim-navic", "echasnovski/mini.icons" },
    event = "BufReadPost",
    config = function()
      local palette = require "rose-pine.palette"
      -- triggers CursorHold event faster
      vim.opt.updatetime = 200

      require("barbecue").setup {
        create_autocmd = false,
        theme = {
          normal = { fg = palette.subtle },
        },
        symbols = {
          separator = " ",
        },
      }

      vim.api.nvim_create_autocmd({
        "WinResized",
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    end,
  },
  {
    "willothy/nvim-cokeline",
    dependencies = { "nvim-lua/plenary.nvim", "echasnovski/mini.icons" },
    event = "BufReadPost",
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
        components = { components.filename, components.modified },
      }
    end,
  },
  {
    "leath-dub/snipe.nvim",
    lazy = true,
    keys = {
      -- stylua: ignore start
      { "<leader><tab>", function() require("snipe").open_buffer_menu() end, desc = "snipe buffer" },
      -- stylua: ignore end
    },
    opts = {},
  },
  {
    "Chaitanyabsprip/fastaction.nvim",
    lazy = false,
    opts = {
      register_ui_select = true,
      popup = {
        border = "single",
        title = "select:",
      },
    },
    keys = {
      -- stylua: ignore start
      { "<leader>ca", function() require("fastaction").code_action() end, desc = "code action", buffer = true },
      -- stylua: ignore end
    },
  },
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
        cmdline_input = {
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
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    opts = {
      winopts = {
        height = 0.25,
        width = 0.4,
        row = 0.5,
        border = "single",
      },
      fzf_opts = {
        ["--no-info"] = "",
        ["--info"] = "hidden",
        ["--padding"] = "13%,5%,13%,5%",
        ["--header"] = " ",
        ["--no-scrollbar"] = "",
      },
      files = {
        formatter = "path.filename_first",
        git_icons = true,
        prompt = "files:",
        preview_opts = "hidden",
        no_header = true,
        cwd_header = false,
        cwd_prompt = false,
        cwd = require("utils.fn").root(),
      },
      search = {
        prompt = "search:",
        cwd = require("utils.fn").root(),
      },
    },
    keys = {
        -- stylua: ignore start
        { "<leader>ff", function() require("fzf-lua").files() end, desc = "find files" },
        { "<leader>fw", function() require("fzf-lua").live_grep() end, desc = "live grep" },
        { "<leader>fw", function() require("fzf-lua").grep_visual() end, mode = "x", desc = "grep selection" },
        { "<leader>fo", function() require("fzf-lua").oldfiles({}) end, desc = "old files" },
      -- stylua: ignore end
    },
  },
  { "nvchad/volt", lazy = true },
  {
    "nvchad/menu",
    lazy = true,
    opts = {},

    keys = {
      -- stylua: ignore start
      { "<C-t>", function() require("menu").open "default" end },
      -- stylua: ignore end
    },
  },
  {
    "folke/edgy.nvim",
    lazy = true,
    event = { "BufWinLeave" },
    opts = function(_, opts)
      opts = {
        animate = {
          enabled = false,
        },
        bottom = {
          { ft = "qf", title = "quickfix" },
          {
            ft = "help",
            size = { height = 20 },
            -- only show help buffers
            filter = function(buf)
              return vim.bo[buf].buftype == "help"
            end,
          },
        },
        right = {
          { title = "grug far", ft = "grug-far", size = { width = 0.4 } },
          { title = "copilot chat", ft = "copilot-chat", size = { width = 50 } },
        },
      }

      --snacks terminal
      for _, pos in ipairs { "top", "bottom", "left", "right" } do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "snacks_terminal",
          size = { height = 0.4 },
          title = "%{b:snacks_terminal.id}",
          filter = function(_, win)
            return vim.w[win].snacks_win
              and vim.w[win].snacks_win.position == pos
              and vim.w[win].snacks_win.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end

      -- trouble
      for _, pos in ipairs { "top", "bottom", "left", "right" } do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "trouble",
          filter = function(_, win)
            return vim.w[win].trouble
              and vim.w[win].trouble.position == pos
              and vim.w[win].trouble.type == "split"
              and vim.w[win].trouble.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end

      -- snacks terminal
      for _, pos in ipairs { "top", "bottom", "left", "right" } do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "snacks_terminal",
          size = { height = 0.4 },
          title = "%{b:snacks_terminal.id}: %{b:term_title}",
          filter = function(_, win)
            return vim.w[win].snacks_win
              and vim.w[win].snacks_win.position == pos
              and vim.w[win].snacks_win.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end
      return opts
    end,
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    lazy = true,
    opts = function(_, opts)
      local palette = require "rose-pine.palette"
      opts = {
        hi = {
          fg = palette.gold,
        },
        smooth = false,
      }
      return opts
    end,
    event = { "BufWinLeave" },
  },
}
