local servers = {
  "cssls",
  "eslint",
  "html",
  "jsonls",
  "lua_ls",
  "marksman",
  "svelte",
  "taplo",
  "yamlls",
  "tailwindcss",
  "lemminx",
  "rust_analyzer",
}

return {
  "neovim/nvim-lspconfig",
event = "User FilePost",
  config = function()

    local lspconfig = require "lspconfig"
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,
      }
    end

    lspconfig.vtsls.setup {
      on_attach = on_attach,
      root_dir = lspconfig.util.root_pattern "package.json",
    }

    lspconfig.denols.setup {
      on_attach = on_attach,
      root_dir = lspconfig.util.root_pattern "deno.json",
    }

    lspconfig.powershell_es.setup {
      on_attach = on_attach,
      bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
      init_options = {
        enableProfileLoading = false,
      },
    }
  end,
  keys = {
    -- stylua: ignore start
    { "gD", function() vim.lsp.buf.declaration()end, desc = "lsp declaration" },
    { "gd", function() vim.lsp.buf.definition()end, desc = "lsp definition" },
    { "K", function() vim.lsp.buf.hover()end, desc = "lsp hover" },
    { "gi", function() vim.lsp.buf.implementation()end, desc = "lsp implementation" },
    { "gK", function() vim.lsp.buf.signature_help()end, desc = "lsp signature help" },
    { "gy", function() vim.lsp.buf.type_definition()end, desc = "lsp type definition" },
    { "gr", function() vim.lsp.buf.references()end, desc = "lsp references" },
    { "[d", function() vim.lsp.diagnostic.goto_prev()end, desc = "lsp goto prev diagnostic" },
    { "]d", function() vim.lsp.diagnostic.goto_next()end, desc = "lsp goto next diagnostic" },
    {"<leader>ti", function() vim.lsp.inlay_hint.enable() end, desc = "inlay hint"},
    -- stylua: ignore start
  },
}
