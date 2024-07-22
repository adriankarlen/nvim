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
        javascript = { "prettier", "eslint", stop_after_first = true },
        typescript = { "prettier", "eslint", stop_after_first = true },
        javascriptreact = { "prettier", "eslint", stop_after_first = true },
        typescriptreact = { "prettier", "eslint", stop_after_first = true },
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
        ["_"] = { "trimwhitespace" },
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
    {
      "<leader>cf",
      function()
        require("conform").format()
      end,
      desc = "format",
      silent = true,
    },
  },
}
