return {
  "j-hui/fidget.nvim",
  event = "BufEnter",
  opts = {
    progress = {
      display = {
        progress_icon = { pattern = "meter", period = 1 },
      },
    },
    notification = {
      override_vim_notify = true,
      poll_rate = 60, -- FPS
      window = {
        winblend = 0,
        border = "single", -- Border around the notification window
      },
    },
  },
}
