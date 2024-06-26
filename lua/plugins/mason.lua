return {
  "williamboman/mason.nvim",
  cond = not vim.g.vscode,
  opts = {},
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require "mason"
    local mason_lspconfig = require "mason-lspconfig"
    local mason_tool_installer = require "mason-tool-installer"

    mason.setup {
      max_concurrent_installers = 10,
      ui = {
        icons = {
          package_pending = " ",
          package_installed = "󰄳 ",
          package_uninstalled = "󰚌 ",
        },

        keymaps = {
          toggle_server_expand = "<CR>",
          install_server = "i",
          update_server = "u",
          check_server_version = "c",
          update_all_servers = "U",
          check_outdated_servers = "C",
          uninstall_server = "X",
          cancel_installation = "<C-c>",
        },
      },
    }

    mason_lspconfig.setup {
      ensure_installed = {
        "vtsls",
        "eslint",
        "html",
        "cssls",
        "svelte",
        "denols",
        "tailwindcss",
        "lua_ls",
        "jsonls",
        "taplo",
        "yamlls",
        "omnisharp",
        "powershell_es",
        "marksman",
      },
    }

    mason_tool_installer.setup {
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "csharpier", -- c# formatter
        "xmlformatter", -- xml formatter
      },
    }
  end,
}
