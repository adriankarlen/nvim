return {
  {
    "yetone/avante.nvim",
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = "copilot",
    },
    event = "BufReadPost",
    build = "pwsh -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false",
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        opts = {
          suggestion = {
            enable = false,
          },
          panel = {
            enable = false,
          },
        },
      },
    },
  },
}
