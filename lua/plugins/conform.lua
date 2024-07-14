return {
  "stevearc/conform.nvim",
  cond = not vim.g.vscode,
  lazy = true,
  event = { "BufWritePre" },
  config = function()
    require("conform").setup {
      quiet = true,
      lsp_fallback = true,
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier", "eslint" },
        typescript = { "prettier", "eslint" },
        javascriptreact = { "prettier", "eslint" },
        typescriptreact = { "prettier", "eslint" },
        svelte = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        mdx = { "prettier" },
        graphql = { "prettier" },
        c_sharp = { "csharpier" },
        xml = { "xmlformat" },
        svg = { "xmlformat" },
        rust = { "rustfmt" },
      },
      formatters = {
        xmlformat = {
          cmd = { "xmlformat" },
          args = { "--selfclose", "-" },
        },
        injected = { options = { ignore_errors = false } },
      },
    }
  end,
  keys = {
    { "<leader>fm", "<cmd>lua require('conform').format()<CR>", desc = "format file", silent = true },
  },
}
