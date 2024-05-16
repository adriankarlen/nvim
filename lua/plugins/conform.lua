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
        javascript = { "prettierd", "eslint_d" },
        typescript = { "prettierd", "eslint_d" },
        javascriptreact = { "prettierd", "eslint_d" },
        typescriptreact = { "prettierd", "eslint_d" },
        svelte = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
        less = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        graphql = { "prettierd" },
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
    { "<leader>fm", "<cmd>lua require('conform').format()<CR>", desc = "Format file", silent = true },
  },
}
