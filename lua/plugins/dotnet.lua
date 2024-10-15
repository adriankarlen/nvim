return {
  {
    "MoaidHathot/dotnet.nvim",
    ft = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets" },
    opts = {},
    keys = {
      -- stylua: ignore start 
      { "<leader>ns", "<cmd>:DotnetUI file bootstrap<cr>", desc = "bootstrap class", silent = true },
      { "<leader>pnR", "<cmd>:DotnetUI project reference remove<cr>", desc = "remove project reference", silent = true },
      { "<leader>pna", "<cmd>:DotnetUI project package add<cr>", desc = "add project package", silent = true },
      { "<leader>pnr", "<cmd>:DotnetUI project package remove<cr>",  desc = "remove project package", silent = true },
      -- stylua: ignore end
    },
  },
  {
    "seblj/roslyn.nvim",
    opts = function()
      require("roslyn").setup {
        ft = "cs",
        config = {
          settings = {
            ["csharp|inlay_hints"] = {
              csharp_enable_inlay_hints_for_implicit_object_creation = true,
              csharp_enable_inlay_hints_for_implicit_variable_types = true,
              csharp_enable_inlay_hints_for_lambda_parameter_types = true,
              csharp_enable_inlay_hints_for_types = true,
              dotnet_enable_inlay_hints_for_indexer_parameters = true,
              dotnet_enable_inlay_hints_for_literal_parameters = true,
              dotnet_enable_inlay_hints_for_object_creation_parameters = true,
              dotnet_enable_inlay_hints_for_other_parameters = true,
              dotnet_enable_inlay_hints_for_parameters = true,
              dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
            },
            ["csharp|code_lens"] = {
              dotnet_enable_references_code_lens = true,
            },
          },
        },
      }
      vim.api.nvim_create_autocmd({ "LspAttach", "InsertLeave" }, {
        pattern = "*",
        callback = function()
          local clients = vim.lsp.get_clients { name = "roslyn" }
          if not clients or #clients == 0 then
            return
          end

          local buffers = vim.lsp.get_buffers_by_client_id(clients[1].id)
          for _, buf in ipairs(buffers) do
            vim.lsp.util._refresh("textDocument/diagnostic", { bufnr = buf })
            vim.lsp.codelens.refresh()
          end
        end,
      })
    end,
  },
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    ft = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets" },
    opts = {
      terminal = function(path, action)
        local commands = {
          run = function()
            return "dotnet run --project " .. path
          end,
          test = function()
            return "dotnet test " .. path
          end,
          restore = function()
            return "dotnet restore " .. path
          end,
          build = function()
            return "dotnet build " .. path
          end,
        }
        local command = commands[action]() .. "\r"
        require("toggleterm.terminal").Terminal
          :new({
            cmd = command,
            close_on_exit = action ~= "test",
            direction = action == "test" and "horizontal" or "float",
          })
          :toggle()
      end,
      test_runner = {
        viewmode = "float",
        icons = {
          project = "󰗀",
        },
      },
    },
    keys = {
      -- stylua: ignore start 
      { "<leader>nb", function() require("easy-dotnet").build_default_quickfix() end, desc = "build" },
      { "<leader>nB", function() require("easy-dotnet").build_quickfix() end, desc = "build solution" },
      { "<leader>nr", function() require("easy-dotnet").run_default() end, desc = "run" },
      { "<leader>nR", function() require("easy-dotnet").run_solution() end, desc = "run solution" },
      { "<leader>nx", function() require("easy-dotnet").clean() end, desc = "clean solution" },
      { "<leader>na", "<cmd>Dotnet new<cr>", desc = "new item" },
      { "<leader>nt", "<cmd>Dotnet testrunner<cr>", desc = "open test runner" },
      -- stylua: ignore end
    },
  },
}
