return {
  "echasnovski/mini.indentscope",
  version = false,
  config = function()
    require("mini.indentscope").setup()
    -- Disable for certain filetypes
    vim.api.nvim_create_autocmd({ "FileType" }, {
      desc = "Disable indentscope for certain filetypes",
      callback = function()
        local ignore_filetypes = {
          "aerial",
          "dashboard",
          "help",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "alpha",
        }
        if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
          vim.b.miniindentscope_disable = true
        end
      end,
    })
  end,
}
