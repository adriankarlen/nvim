-- autocmd that only loads git plugins if within a git repo
vim.api.nvim_create_autocmd({ "BufRead" }, {
  group = vim.api.nvim_create_augroup("LazyLoadGitPlugins", { clear = true }),
  callback = function()
    vim.fn.jobstart({ "git", "-C", vim.loop.cwd(), "rev-parse" }, {
      on_exit = function(_, return_code)
        if return_code == 0 then
          vim.api.nvim_del_augroup_by_name "LazyLoadGitPlugins"
          vim.schedule(function()
           require("lazy").load { plugins = { "mini.diff", "git-conflict.nvim" } }
          end)
        end
      end,
    })
  end,
})

return {
  {
    "akinsho/git-conflict.nvim",
    lazy = true,
    version = "*",
    opts = {},
  },
}
