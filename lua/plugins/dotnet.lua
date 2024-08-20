return {
  {
    "MoaidHathot/dotnet.nvim",
    ft = { "cs" },
    opts = {},
    keys = {
      -- stylua: ignore start 
      { "<leader>na", "<cmd>:DotnetUI new_item<cr>", desc = "new item" },
      { "<leader>nb", "<cmd>:DotnetUI file bootstrap<cr>", desc = "bootstrap class", silent = true},
      { "<leader>nra", "<cmd>:DotnetUI project reference add<cr>", desc = "add project reference", silent = true },
      { "<leader>nrr", "<cmd>:DotnetUI project reference remove<cr>", desc = "remove project reference", silent = true},
      { "<leader>npa", "<cmd>:DotnetUI project package add<cr>", desc = "add project package", silent = true},
      { "<leader>npr", "<cmd>:DotnetUI project package remove<cr>",  desc = "remove project package", silent = true },
      -- stulua: ignore end
    },
  },
  {
    "seblj/roslyn.nvim",
    opts = function()
      require("roslyn").setup {
        ft = "cs",
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
          end
        end,
      })
    end,
  },
}
