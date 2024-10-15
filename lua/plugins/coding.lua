return {
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
    ft = {
      "html",
      "svelte",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "markdown",
      "xml",
    },
  },
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = {},
    keys = {
      {
        "<leader>cr",
        function()
          return ":IncRename " .. vim.fn.expand "<cword>"
        end,
        expr = true,
        desc = "rename",
      },
    },
  },
  { "folke/ts-comments.nvim", event = "VeryLazy", opts = {} },
}
