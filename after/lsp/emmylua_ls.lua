-- Adjust semantic token highlighting:
-- - Don't extra highlight keywords, tree-sitter seems to do a better job
vim.api.nvim_set_hl(0, "@lsp.type.keyword.lua", { fg = "NONE" })
-- - Don't extra highlight strings, tree-sitter injections do much better job
vim.api.nvim_set_hl(0, "@lsp.type.string.lua", { fg = "NONE" })
-- - But still highlight special words in documentation (like ---@param).
vim.api.nvim_set_hl(0, "@lsp.mod.documentation.lua", { link = "Statement" })

-- Scan the Neovim pack directory directly so plugins loaded via `later()`
-- (i.e. not yet in runtimepath when emmylua starts) are still resolvable.
-- `nvim_get_runtime_file("lua", true)` only sees plugins already in rtp.
local function nvim_pack_lib_paths()
  local out, seen = {}, {}
  for _, kind in ipairs({ "start", "opt" }) do
    local glob = table.concat({ vim.fn.stdpath "data", "site/pack", "*", kind, "*/lua" }, "/")
    for _, p in ipairs(vim.fn.glob(glob, true, true)) do
      if not seen[p] and vim.fn.isdirectory(p) == 1 then
        seen[p] = true
        out[#out + 1] = p
      end
    end
  end
  return out
end

return {
  settings = {
    emmylua = {
      diagnostics = {
        disable = { "undefined-global" },
      },
      runtime = { version = "LuaJIT" },
      workspace = {
        library = vim.list_extend(
          { vim.env.VIMRUNTIME },
          vim.list_extend(nvim_pack_lib_paths(), vim.api.nvim_get_runtime_file("lua", true))
        ),
        ignoreDir = { "dual", "deps" },
      },
    },
  },
}
