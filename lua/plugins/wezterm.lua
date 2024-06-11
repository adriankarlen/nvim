return {
  "willothy/wezterm.nvim",
  config = function()
    local fn = require "utils.fn"
    local autocmd = vim.api.nvim_create_autocmd
    local wezterm = require "wezterm"
    local curr_dir = fn.get_curr_dir() or ""

    autocmd("VimEnter", {
      callback = function()
        local title = string.format(" %s", curr_dir)
        wezterm.set_tab_title(title)
      end,
      once = true,
    })

    autocmd("VimLeave", {
      callback = function()
        local title = string.format(" %s", curr_dir)
        wezterm.set_tab_title(title)
      end,
      once = true,
    })
  end,
}
