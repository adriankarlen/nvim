return {
  "stevearc/conform.nvim",
  -- Code formatter
  config = function()
    require("conform").setup {
      lsp_fallback = true,

      formatters = {
        xmlformat = {
          cmd = { "xmlformat" },
          args = { "--selfclose", "-" },
        },
      },

      formatters_by_ft = {
        lua = { "stylua" },

        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        css = { "prettierd" },
        less = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },

        c_sharp = { "csharpier" },
        xml = { "xmlformat" },
        svg = { "xmlformat" },
      },
    }
  end,
  event = "VeryLazy",
  keys = {
    { "<leader>fm", "<cmd>lua require('conform').format()<CR>", desc = "Format file", silent = true },
  },
}
