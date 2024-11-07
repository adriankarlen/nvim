return {
  "neovim/nvim-lspconfig",
  cond = not vim.g.vscode,
  lazy = false,
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require "mason"
    local mason_tool_installer = require "mason-tool-installer"
    local mason_lspconfig = require "mason-lspconfig"

    local servers = {
      cssls = {},
      eslint = {},
      html = {},
      jsonls = {},
      lemminx = {},
      lua_ls = {},
      marksman = {},
      powershell_es = {
        bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
        init_options = {
          enableProfileLoading = false,
        },
      },
      rust_analyzer = {},
      svelte = {},
      tailwindcss = {},
      taplo = {},
      vtsls = {},
      yamlls = {},
    }

    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, {
      "csharpier", -- c# formatter
      "netcoredbg", -- c# debugger
      "prettier", -- prettier formatter
      "rustywind", -- tailwind class sorter
      "stylua", -- lua formatter
      "xmlformatter", -- xml formatter
    })

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
      registries = {
        "github:mason-org/mason-registry",
        "github:syndim/mason-registry",
      },
    }
    mason_tool_installer.setup { ensure_installed = ensure_installed }
    mason_lspconfig.setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = require("blink.cmp").get_lsp_capabilities(server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    }
  end,
  keys = {
    -- stylua: ignore start
    { "gD", function() vim.lsp.buf.declaration()end, desc = "lsp declaration" },
    { "gd", function() vim.lsp.buf.definition()end, desc = "lsp definition" },
    { "K", function() vim.lsp.buf.hover()end, desc = "lsp hover" },
    { "gi", function() vim.lsp.buf.implementation()end, desc = "lsp implementation" },
    { "gK", function() vim.lsp.buf.signature_help()end, desc = "lsp signature help" },
    { "gy", function() vim.lsp.buf.type_definition()end, desc = "lsp type definition" },
    { "gr", function() vim.lsp.buf.references()end, desc = "lsp references" },
    { "[d", function() vim.lsp.diagnostic.goto_prev()end, desc = "lsp goto prev diagnostic" },
    { "]d", function() vim.lsp.diagnostic.goto_next()end, desc = "lsp goto next diagnostic" },
    {"<leader>ti", function() vim.lsp.inlay_hint.enable() end, desc = "inlay hint"},
    -- stylua: ignore start
  },
}
