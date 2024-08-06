return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enable = false,
      },
      panel = {
        enable = false,
      },
    },
  },
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "Jezda1337/nvim-html-css",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("html-css"):setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    opts = {},
    config = function()
      local cmp = require "cmp"
      require("luasnip.loaders.from_vscode").lazy_load()

      local disabled_filetypes = {
        "minifiles",
        "TelescopePrompt",
      }

      cmp.setup {
        enabled = function()
          return not vim.tbl_contains(disabled_filetypes, vim.bo.filetype)
        end,
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = {
            border = "single",
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
          },
          documentation = cmp.config.window.bordered {
            border = "single",
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          expandable_indicator = true,
          format = function(_, vim_item)
            if _G.MiniIcons then
              local icon, hl, _ = MiniIcons.get("lsp", vim_item.kind)
              vim_item.menu = "    (" .. vim_item.kind .. ")"
              vim_item.kind = " " .. (icon or "") .. " "
              vim_item.kind_hl_group = hl
            end
            return vim_item
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
        },
        sources = {
          { name = "nvim_lsp", group_index = 2 },
          { name = "copilot", group_index = 2 },
          { name = "luasnip", group_index = 2 },
          { name = "buffer", group_index = 2 },
          { name = "nvim_lua", group_index = 2 },
          { name = "path", group_index = 2 },
          { name = "cmdline", group_index = 2 },
          {
            name = "html-css",
            group_index = 2,
            option = {
              enable_on = { "html", "jsx", "tsx", "mdx" },
              file_extensions = { "css", "less", "scss" },
            },
          },
        },
      }
    end,
  },
}
