return {
  "williamboman/mason.nvim",
  cond = not vim.g.vscode,
  cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
  opts = {
    max_concurrent_installers = 10,
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "",
      },
      border = "single",
    },
  },
  dependencies = {

    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {
          "vtsls",
          "eslint",
          "html",
          "cssls",
          "svelte",
          "tailwindcss",
          "lua_ls",
          "jsonls",
          "taplo",
          "yamlls",
          "omnisharp",
          "powershell_es",
          "marksman",
          "lemminx",
          "rust_analyzer",
        },
      },
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = {
        ensure_installed = {
          "prettier", -- prettier formatter
          "rustywind", -- tailwind class sorter
          "stylua", -- lua formatter
          "csharpier", -- c# formatter
          "netcoredbg", -- c# debugger
          "xmlformatter", -- xml formatter
        },
      },
    },
  },
}
