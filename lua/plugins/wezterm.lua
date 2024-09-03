return {
  "willothy/wezterm.nvim",
  config = function()
    local autocmd = vim.api.nvim_create_autocmd
    local wezterm = require "wezterm"
    local cwd = vim.fs.basename(vim.fn.getcwd())

    autocmd("VimEnter", {
      callback = function()
        local title = string.format(" %s", cwd)
        wezterm.set_user_var("IS_NVIM", true)
        wezterm.set_tab_title(title)
      end,
      once = true,
    })

    autocmd("ExitPre", {
      callback = function()
        local title = string.format(" %s", cwd)
        wezterm.set_user_var("IS_NVIM", false)
        wezterm.set_tab_title(title)
      end,
      once = true,
    })
  end,
}
