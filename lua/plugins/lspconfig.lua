local servers = { "eslint", "html", "cssls", "tsserver", "clangd", "lua_ls", "jsonls" }
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

lspconfig.omnisharp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "C:/Users/ADKA01/AppData/Local/nvim-data/mason/bin/omnisharp.cmd" },
  -- Enables support for reading code style, naming convention and analyzer
  -- settings from .editorconfig.
  enable_editorconfig_support = true,
  -- If true, MSBuild project system will only load projects for files that
  -- were opened in the editor. This setting is useful for big C# codebases
  -- and allows for faster initialization of code navigation features only
  -- for projects that are relevant to code that is being edited. With this
  -- setting enabled OmniSharp may load fewer projects and may thus display
  -- incomplete reference lists for symbols.
  enable_ms_build_load_projects_on_demand = false,
  -- Enables support for roslyn analyzers, code fixes and rulesets.
  enable_roslyn_analyzers = false,
  -- Specifies whether 'using' directives should be grouped and sorted during
  -- document formatting.
  organize_imports_on_format = true,
  -- Enables support for showing unimported types and unimported extension
  -- methods in completion lists. When committed, the appropriate using
  -- directive will be added at the top of the current file. This option can
  -- have a negative impact on initial completion responsiveness,
  -- particularly for the first few completion sessions after opening a
  -- solution.
  enable_import_completion = true,
  -- Specifies whether to include preview versions of the .NET SDK when
  -- determining which version to use for project loading.
  sdk_include_prereleases = true,
  -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
  -- true
  analyze_open_documents_only = false,
}
  end,
  keys = {
    { "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", desc = "lsp declaration" },
    { "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", desc = "lsp definition" },
    { "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", desc = "lsp hover" },
    { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "lsp implementation" },
    { "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "lsp signature help" },
    { "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "lsp type definition" },
    { "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "lsp rename" },
    -- { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", mode = { "n", "v" }, desc = "lsp code action" },
    { "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "lsp references" },
    { "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", desc = "lsp goto prev diagnostic" },
    { "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", desc = "lsp goto next diagnostic" },
    { "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", desc = "lsp set loclist" },
  },
}
