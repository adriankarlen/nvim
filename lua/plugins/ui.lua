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
              " Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
            }
          end,
        },
      }
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = "BufEnter",
    opts = {
      progress = {
        display = {
          progress_icon = { pattern = "meter", period = 1 },
        },
      },
      notification = {
        override_vim_notify = true,
        poll_rate = 60, -- FPS
        window = {
          winblend = 0,
          border = "single", -- Border around the notification window
        },
      },
    },
  },
  {
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
  },
  {
    "stevearc/quicker.nvim",
    opts = {},
  },
  {
    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "Myzel394/jsonfly.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
      },
      lazy = false,
      config = function()
        require("telescope").setup {
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown {},
            },
          },
          defaults = {
            vimgrep_arguments = {
              "rg",
              "-L",
              "--color=never",
              "--no-heading",
              "--with-filename",
              "--line-number",
              "--column",
              "--smart-case",
            },
            prompt_prefix = "   ",
            selection_caret = "  ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
              horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
              },
              vertical = {
                mirror = false,
              },
              width = 0.87,
              height = 0.80,
              preview_cutoff = 120,
            },
            file_sorter = require("telescope.sorters").get_fuzzy_file,
            file_ignore_patterns = { "node_modules" },
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            path_display = {
              filename_first = {
                reverse_directories = false,
              },
            },
            winblend = 0,
            border = {},
            borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            -- color_devicons = true,
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
            mappings = {
              n = { ["q"] = require("telescope.actions").close },
            },
          },
          pickers = {
            find_files = {
              find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
            },
          },
        }
        require("telescope").load_extension "ui-select"
        require("telescope").load_extension "jsonfly"
        require("telescope").load_extension "noice"
      end,
      keys = {
        -- stylua: ignore start
        { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "find files" },
        { "<leader>fa", function() require("telescope.builtin").find_files { hidden = true, follow = true, no_ignore = true } end, desc = "find all files" },
        { "<leader>fw", function() require("telescope.builtin").live_grep() end, desc = "live grep" },
        { "<leader>fo", function() require("telescope.builtin").oldfiles() end, desc = "old files" },
        { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "buffers" },
        { "<leader>fj", "<cmd>telescope - jsonfly<cr>", desc = "json(fly)", ft = { "json", "xml", "yaml" } },
        { "<leader>fn", "<cmd>Telescope noice<cr>", desc = "noice" },
        -- stylua: ignore end
      },
    },
  },
}
