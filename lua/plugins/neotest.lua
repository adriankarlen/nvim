return {
  {
    "Issafalcon/neotest-dotnet",
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-dotnet" {
            dotnet_additional_args = {
              "--runtime win-x64",
            },
            discovery_root = "solution",
          },
        },
      }
    end,
    -- stylua: ignore
    keys = {
      { "<leader>tt", function() require("neotest").run.run({ vim.fn.expand("%"), dotnet_additional_args = { "--runtime win-x64" } }) end, desc = "run-file" },
      { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "run all test files" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "run nearest" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "run last" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "toggle summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "show output" },
      { "<leader>to", function() require("neotest").output_panel.toggle() end, desc = "toggle output panel" },
      { "<leader>ts", function() require("neotest").run.stop() end, desc = "stop" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "toggle watch" },
    },
  },
}
