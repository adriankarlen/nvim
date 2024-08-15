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
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "",
        },
        border = "single",
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
        "lemminx",
      },
    }

    mason_tool_installer.setup {
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "csharpier", -- c# formatter
        "netcoredbg", -- c# debugger
        "xmlformatter", -- xml formatter
      },
    }
  end,
}
