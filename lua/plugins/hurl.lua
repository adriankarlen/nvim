return {
  "jellydn/hurl.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = "hurl",
  opts = {
    show_notification = true,
    mode = "popup",
  },
  keys = {
    -- Run API request
    { "<leader>hr", "<cmd>HurlRunnerAt<CR>", desc = "Run Api request" },
    { "<leader>ha", "<cmd>HurlRunner<CR>", desc = "Run All requests" },
    { "<leader>hA", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
    { "<leader>he", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
    { "<leader>ht", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
    {
      "<leader>hv",
      function()
        local var_name = vim.fn.input "Enter env variable name: "
        local var_value = vim.fn.input "Enter env variable value: "
        if var_name ~= "" and var_value ~= "" then
          vim.cmd("HurlSetVariable " .. var_name .. " " .. var_value)
        end
      end,
      desc = "add env variable",
    },
    { "<leader>hm", "<cmd>HurlManageVariable<cr>", desc = "manage variable" },
    -- Run Hurl request in visual mode
    { "<leader>h", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
  },
}
