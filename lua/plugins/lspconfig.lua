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
  "lemminx",
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

    lspconfig.omnisharp.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { vim.fn.stdpath "data" .. "/mason/bin/omnisharp.cmd" },
      enable_ms_build_load_projects_on_demand = false,
      enable_editorconfig_support = true,
      enable_roslyn_analysers = true,
      enable_import_completion = true,
      organize_imports_on_format = true,
      enable_decompilation_support = true,
      analyze_open_documents_only = false,
      filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets" },
    }

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
    { "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", desc = "lsp declaration" },
    { "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", desc = "lsp definition" },
    { "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", desc = "lsp hover" },
    { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "lsp implementation" },
    { "gK", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "lsp signature help" },
    { "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "lsp type definition" },
    { "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "lsp references" },
    { "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", desc = "lsp goto prev diagnostic" },
    { "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", desc = "lsp goto next diagnostic" },
  },
}
