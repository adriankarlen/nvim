return {
  {
    "leath-dub/snipe.nvim",
    lazy = true,
    enabled = false,
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
        x_offset = vim.api.nvim_get_option_value("columns", {}),
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
    keys = {
        -- stylua: ignore start
        { "<leader>ff", function() require("fzf-lua").files() end, desc = "find files" },
        { "<leader>fw", function() require("fzf-lua").live_grep() end, desc = "live grep" },
        { "<leader>fw", function() require("fzf-lua").grep_visual() end, mode = "x", desc = "grep selection" },
        { "<leader>fo", function() require("fzf-lua").oldfiles() end, desc = "old files" },
        { "<leader><tab>", function() require("fzf-lua").buffers() end, desc = "buffers" },
      -- stylua: ignore end
    },
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
      grep = {
        prompt = "search:",
        cwd = require("utils.fn").root(),
      },
      buffers = {
        prompt = "buffers:",
        preview_opts = "hidden",
      },
      oldfiles = {
        prompt = "history:",
      },
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
          { title = "code companion", ft = "codecompanion", size = { width = 50 } },
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
  {
    "adriankarlen/buffed.nvim",
    event = "BufReadPost",
    dependencies = { "echasnovski/mini.icons" },
    opts = {},
    keys = {
      {
        "<leader>fb",
        function()
          vim.ui.select(require("buffed").buffs(), { prompt = "select buff" }, function(selection)
            vim.cmd.edit(selection)
          end)
        end,
        desc = "select buff",
      },
      {
        "<leader>fd",
        function()
          vim.ui.select(require("buffed").debuffs(), { prompt = "select debuff" }, function(selection)
            vim.cmd.edit(selection)
          end)
        end,
        desc = "select debuff",
      },
    },
  },
}
