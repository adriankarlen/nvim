return {
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = { "SmiteshP/nvim-navic", "echasnovski/mini.icons" },
    event = "BufWinEnter",
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
          separator = "",
        },
      }

      vim.api.nvim_create_autocmd({
        "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",

        -- include this if you have set `show_modified` to `true`
        "BufModifiedSet",
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
    "ghillb/cybu.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "echasnovski/mini.icons" },
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

      -- stylua: ignore start
      { "<tab>", function() require("cybu").cycle "next" end, mode = { "n", "v" }, desc = "cybu - next" },
      { "<s-tab>", function() require("cybu").cycle "prev" end, mode = { "n", "v" }, desc = "cybu - prev" },
      -- stylua: ignore end
    },
    event = "BufRead",
  },
  {
    "leath-dub/snipe.nvim",
    keys = {
      -- stylua: ignore start
      { "<leader><tab>", function() require("snipe").open_buffer_menu() end, desc = "snipe buffer menu" },
      -- stylua: ignore end
    },
    opts = {},
  },
  {
    "Chaitanyabsprip/fastaction.nvim",
    event = "VeryLazy",
    opts = {
      register_ui_select = true,
      popup = {
        border = "single",
        hide_cursor = true,
        highlight = {
          divider = "FloatBorder",
          key = "MoreMsg",
          title = "Title",
          window = "NormalFloat",
        },
        title = "Select:",
      },
    },
    keys = {
      -- stylua: ignore start
      { "<leader>ca", function() require("fastaction").code_action() end, desc = "code action", buffer = true },
      -- stylua: ignore end
    },
  },
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPre",
    config = function()
      require("scrollbar").setup {
        hide_if_all_visible = true,
        handle = {
          blend = 0,
        },
        handlers = {
          gitsigns = true,
        },
      }
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    lazy = false,
    dependencies = { "echasnovski/mini.icons" },
    opts = function()
      local snufkin = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠄⠒⠊⠉⢱⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠃⠀⠀⠀⡰⢾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⠁⠀⠀⠈⠉⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⢀⠀⠀⠀⠀⠀⢠⠎⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠒⠢⠤⣷⠒⢾⠂⡡⢒⣦⠒⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⣷⣴⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣥⠀⢰⣋⡩⣴⣿⠎⠣⢶⡏⡖⣰⠠⣦⣠⣧⠤⣴⣂⣞⠙⡏⡸⢛⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠢⡉⠣⢲⣱⣁⡟⣓⠀⣴⣶⢑⣊⣹⡈⣣⣔⠡⠾⢄⠡⣿⠆⣋⣱⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⢀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⡦⡋⠛⠿⠥⡖⣸⢀⢦⣼⡴⢂⢙⠋⣌⣙⡥⢞⣰⠦⠜⠫⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠌⢰⠀⠀⠀⠀⠀⡘⡃⣮⢱⣷⠀⠀⠀⠀⠀⠀⠀⠀⢰⢸⣿⡦⢄⡀⠈⠀⠁⠛⠩⠾⠑⠚⢒⠙⢉⡃⡀⠙⣀⠤⠊⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢠⣢⢠⢓⠂⢤⠀⢸⣼⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⢸⠰⢉⡀⢔⠅⠉⢩⣷⣶⠒⠈⡏⠉⠁⠙⡕⣾⣏⡓⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⢒⡓⡾⣟⠂⡠⠊⠀⠀⠻⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⢆⠘⠥⣀⡀⠓⡄⠫⣁⠠⠞⠀⠀⠀⣸⡔⠒⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠔⠊⠐⠄⠀⠀⠀⠀⠀⠀⠐⡌⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⢄⡢⠄⣉⡁⠀⠀⠀⠀⢀⡠⡖⠁⣀⠤⠒⠂⠉⠉⠉⠐⠒⠤⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣾⡆⠀⠀⠀⠀⠀⠀⠀⢀⡤⠊⠔⢁⡝⡖⣷⠲⠶⣮⠹⠖⠋⢸⠊⠀⠀⠀⠀⠀⠀⢱⡀⡀⠀⠈⢠⣦⣸⡿⣀⡀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣸⣼⡇⡆⠀⠀⢽⣷⠒⢤⣾⣦⣄⡠⠊⣑⠕⢁⠔⡱⡌⠈⢿⣰⣤⡦⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⣧⢱⡀⢠⣶⢮⡀⣸⣛⠃⠀
⠀⠀⠀⠀⠀⠀⠀⢀⡀⡂⡄⢀⡀⡄⢠⠀⠀⠀⠀⣿⣿⣿⣷⠃⢀⢼⠬⠭⡿⣸⣯⢟⠋⣱⣄⠉⠉⠛⠦⠟⠀⠀⠈⠛⠛⠁⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⢸⡄⣧⠀⠀⠸⠿⠙⠿⠃⠀
⠀⠀⠀⠀⠀⠀⠀⠑⡔⡇⢰⠱⠁⢸⠀⡇⠀⢆⠀⠸⢿⠿⡫⠊⡱⢸⠫⠝⠳⠜⣿⣯⡻⡟⢊⡗⡄⠀⠀⠀⠀⠀⠀⠀⠀⣀⠤⢀⠄⡌⠀⠀⠀⠀⠀⠀⢸⡄⠈⣇⢹⡆⠀⠀⡎⠀⡔⢠⠃
⠀⠀⠀⠀⠀⠀⠈⢆⠃⠃⠈⡗⡀⢸⡆⣿⢠⠸⡄⠀⡼⠊⠀⢠⠁⢸⠀⠀⢀⡠⣪⢿⢛⣚⠿⠃⢛⠀⠀⠀⠀⠀⢀⠔⠊⠀⢀⠎⢀⠃⠀⠀⠀⠀⠀⡄⠀⡼⡀⣿⠸⣷⠀⢠⠇⡼⠀⡞⢀
⠀⠀⠀⠀⠄⠀⠐⠈⣾⠀⠀⣧⣧⢸⡇⣿⢸⠀⣧⠘⡄⠀⠀⢸⠀⠨⠒⠊⡡⠊⠀⠀⢳⣂⡈⠀⢀⠕⠒⠒⠤⠾⠥⡀⠀⣠⠊⠀⡜⠀⠀⠀⠀⠀⠀⢳⠀⡇⡇⡿⡄⣿⡀⢸⢸⠇⢰⡇⡜
⠀⠀⠀⢢⠈⡄⠀⡇⢿⡀⢀⡇⢻⢸⣇⡟⣸⠠⠟⣴⣿⣿⣤⠈⠀⠀⠠⠊⠀⠀⠀⠀⠀⠈⠰⠲⡏⡀⠀⠀⠀⠀⠀⠀⠔⠁⠀⢰⠁⠀⠀⠀⠀⠀⠀⢸⡄⡇⢱⣷⡇⢿⡇⣾⣾⠀⢸⢃⡇
⠀⠀⠀⠀⢣⢸⡄⢷⢸⡿⡧⡇⢸⠘⢨⣧⡁⠀⠀⣨⣽⣿⠟⠉⠁⢈⣽⣄⠀⠀⠀⠀⠀⠀⠀⠇⠐⢌⠑⠢⠤⣀⡀⠀⠀⡀⡰⡁⠠⡀⠀⠀⠀⠀⠀⢸⣇⠇⡏⢻⢸⢸⡇⣿⣿⠀⢸⢸⡇
⠀⠀⠀⠀⠈⣇⣧⢸⠸⡇⡇⡇⢸⠀⠈⢿⣿⣶⣶⣾⡿⠋⠀⠀⠀⢛⣿⣿⣿⠦⣞⣠⠠⡚⠀⠸⡄⠀⠣⡀⠀⠀⠀⠉⠉⣰⠣⠆⣁⡓⠡⢇⠆⠀⠀⠀⠘⠀⠃⣿⢸⢸⡇⣿⣿⡄⠸⠋⠃
⠀⠀⠀⠀⠀⢸⣸⣼⡆⠃⠃⣧⠛⠀⠀⠀⠉⠉⠻⣿⣿⣶⣦⣤⣶⡟⠁⠙⠁⠀⠀⠈⠀⢅⡀⠀⠀⠀⠀⠈⠀⠀⠀⢀⠜⠑⢏⢁⠍⣍⣑⠭⠀⣀⣀⡀⠲⠖⠀⡿⠸⢸⡇⠈⠘⠇⠀⠀⠀
⠀⠀⠀⠀⠀⠈⡏⡇⠃⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠈⠋⠉⢹⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠩⢶⠆⠀⠐⠾⠿⣷⠂⢠⣤⣤⡌⠹⠇⠠⠀⠘⠛⠛⠁⠀⠀⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣤⣴⠆⠀⠀⢀⣀⠀⠺⠿⠟⠀⠠⡶⣶⡗⠀⠀⠀⠓⠶⠀⠀⠀⠀⠀⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ]]

      return {
        theme = "hyper",
        shortcut_type = "number",
        config = {
          hide = {
            statusline = false,
          },
          header = vim.split(snufkin, "\n"),
          packages = { enable = false },
          project = { enable = false },
          shortcut = {
            -- stylua: ignore start
            { icon = "󰥨 ", desc = "find files", group = "DiagnosticWarn", key = "f", action = "Telescope find_files" },
            { icon = " ", desc = "browse git", group = "DiagnosticWarn", key = "g", action = "LazyGit" },
            { icon = "󰒲 ", desc = "lazy", group = "DiagnosticWarn", key = "l", action = "Lazy" },
            { icon = "󱌣 ", desc = "mason", group = "DiagnosticWarn", key = "m", action = "Mason" },
            { icon = "󰭿 ", desc = "quit", group = "DiagnosticWarn", key = "q", action = "qa" },
            -- stylua: ignore end
          },
          mru = {
            cwd_only = true,
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return {
              [[                                                                                    ]],
              " Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
            }
          end,
        },
      }
    end,
  },
}
