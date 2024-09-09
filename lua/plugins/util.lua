return {
  {
    -- Enables jj and jk commands to exit insert mode
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
    event = "InsertEnter",
  },
  {
    "chrishrb/gx.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1
    end,
    submodules = false,
    opts = {
      handlers = {
        jira = {
          name = "jira",
          handle = function(mode, line, _)
            local ticket = require("gx.helper").find(line, mode, "(%u+-%d+)")
            if ticket and #ticket < 20 then
              return "http://jira.storebrand.no/browse/" .. ticket
            end
          end,
        },
      },
      handler_options = {
        search_engine = "https://search.brave.com/search?q=",
        select_for_search = false,
        git_remotes = { "upstream", "origin" },
        git_remote_push = true,
      },
    },
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
  },
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>Th", "<cmd>Hardtime toggle<cr>", desc = "hardtime" },
    },
  },
  {
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
      { "<leader>hr", "<cmd>HurlRunnerAt<CR>", desc = "run api request" },
      { "<leader>ha", "<cmd>HurlRunner<CR>", desc = "run all requests" },
      { "<leader>hA", "<cmd>HurlVerbose<CR>", desc = "run api in verbose mode" },
      { "<leader>he", "<cmd>HurlRunnerToEntry<CR>", desc = "run api request to entry" },
      { "<leader>ht", "<cmd>HurlToggleMode<CR>", desc = "toggle popup/split result" },
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
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
        use_absolute_path = true,
      },
    },
    keys = {
      { "<leader>cp", "<cmd>PasteImage<cr>", desc = "paste image from clipboard" },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "LazyVim", words = { "LazyVim" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },
  {
    "tris203/precognition.nvim",
    event = "BufRead",
    keys = {
      {
        "<leader>Tp",
        function()
          require("precognition").toggle()
        end,
        desc = "precognition",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require "nvim-treesitter.configs"
      config.setup {
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
  {
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
  },
}
