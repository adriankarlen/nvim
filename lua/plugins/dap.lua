local fn = require "utils.fn"

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap = require "dap"
      dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
      dap.adapters.coreclr = {
        type = "executable",
        command = "netcoredbg",
        args = { "--interpreter=vscode" },
      }
      dap.adapters.netcoredbg = {
        type = "executable",
        command = "netcoredbg",
        args = { "--interpreter=vscode" },
      }

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          -- env = "ASPNETCORE_ENVIRONMENT=Development",
          -- args = {
          --   "/p:EnvironmentName=Development", -- this is a msbuild jk
          --   --  this is set via environment variable ASPNETCORE_ENVIRONMENT=Development
          --   "--environment=Development",
          -- },
          program = function()
            return fn.get_cs_debug_dll()
          end,
        },
      }
    end,
    event = "VeryLazy",
    keys = {
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        noremap = true,
        silent = true,
        desc = "continue",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        noremap = true,
        silent = true,
        desc = "step over",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        noremap = true,
        silent = true,
        desc = "step into",
      },
      {
        "<leader>du",
        function()
          require("dap").step_out()
        end,
        noremap = true,
        silent = true,
        desc = "step out",
      },
      {
        "<leader>dr",
        function()
          require("dap").restart()
        end,
        noremap = true,
        silent = true,
        desc = "restart",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        noremap = true,
        silent = true,
        desc = "terminate",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        noremap = true,
        silent = true,
        desc = "toggle breakpoint",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap, dapui = require "dap", require "dapui"

      dapui.setup {
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 0.25,
            position = "bottom",
          },
        },
        -- controls = {
        --   enabled = true,
        --   element = "repl",
        --   icons = {
        --     pause = "",
        --     play = "",
        --     step_into = "",
        --     step_over = "",
        --     step_out = "",
        --     step_back = "",
        --     run_last = "",
        --     terminate = "",
        --   },
        -- },
        floating = {
          max_height = nil,
          max_width = nil,
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil,
          max_value_lines = 100,
        },
      }

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
