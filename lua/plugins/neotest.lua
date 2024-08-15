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
      local neotest_ns = vim.api.nvim_create_namespace "neotest"
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      require("neotest").setup {
        adapters = {
          require "neotest-dotnet",
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
        quickfix = {
          open = function()
            if LazyVim.has "trouble.nvim" then
              require("trouble").open { mode = "quickfix", focus = false }
            else
              vim.cmd "copen"
            end
          end,
        },
      }
    end,
    -- stylua: ignore
    keys = {
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "run file" },
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
