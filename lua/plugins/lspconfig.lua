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
  lazy = false,
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local lspconfig = require "lspconfig"
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end

    lspconfig.vtsls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern "package.json",
    }

    lspconfig.denols.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern "deno.json",
    }

    -- lspconfig.omnisharp.setup {
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   cmd = { vim.fn.stdpath "data" .. "/mason/bin/omnisharp.cmd" },
    --   enable_ms_build_load_projects_on_demand = false,
    --   enable_editorconfig_support = true,
    --   enable_roslyn_analysers = true,
    --   enable_import_completion = true,
    --   organize_imports_on_format = true,
    --   enable_decompilation_support = true,
    --   analyze_open_documents_only = false,
    --   filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets" },
    -- }

    lspconfig.powershell_es.setup {
      on_attach = on_attach,
      capabilities = capabilities,
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
    {"<leader>Ti", function() vim.lsp.inlay_hint.enable() end, desc = "inlay hint"},
    -- stylua: ignore start
  },
}
