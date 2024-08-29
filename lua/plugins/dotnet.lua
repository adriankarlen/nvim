return {
  {
    "MoaidHathot/dotnet.nvim",
    ft = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets" },
    opts = {},
    keys = {
      -- stylua: ignore start 
      { "<leader>na", "<cmd>:DotnetUI new_item<cr>", desc = "new item" },
      { "<leader>ns", "<cmd>:DotnetUI file bootstrap<cr>", desc = "bootstrap class", silent = true},
      { "<leader>pnA", "<cmd>:DotnetUI project reference add<cr>", desc = "add project reference", silent = true },
      { "<leader>pnR", "<cmd>:DotnetUI project reference remove<cr>", desc = "remove project reference", silent = true},
      { "<leader>pna", "<cmd>:DotnetUI project package add<cr>", desc = "add project package", silent = true},
      { "<leader>pnr", "<cmd>:DotnetUI project package remove<cr>",  desc = "remove project package", silent = true },
      -- stylua: ignore end
    },
  },
  {
    "adamkali/dotnvim",
    ft = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets" },
    opts = {},
    keys = {
      -- stylua: ignore start 
      { "<leader>nb", function() require("dotnvim").build(true) end, desc = "build last project" },
      { "<leader>nw", function() require("dotnvim").watch(true) end, desc = "watch last project" },
      { "<leader>nW", function() require("dotnvim").restart_watch() end, desc = "restart watch job" },
      { "<leader>nx", function() require("dotnvim").shutdown_watch() end, desc = "shutdown watch job" },
      { "<leader>pns", function() require("dotnvim").nuget_auth() end, desc = "authenticate nuget sources" },
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
}
