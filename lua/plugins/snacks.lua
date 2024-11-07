return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
  bigfile = { enabled = true },
    bufdelete = { enabled = true },
    git = { enabled = true },
    lazygit = { enabled = true },
    statuscolumn = { enabled = true },
    rename = { enabled = true },
  },
  keys = {
    -- stylua: ignore start
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "delete buffer" },
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "blame line" },
    { "<leader>gl", function() Snacks.lazygit() end, desc = "lazygit" },
    { "<leader>cR", function() Snacks.rename() end, desc = "rename file" },
    -- stylua: ignore end
  },
}
