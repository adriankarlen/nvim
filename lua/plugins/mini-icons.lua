return {
  "echasnovski/mini.icons",
  opts = {
    file = {
      ["init.lua"] = { glyph = "󰢱", hl = "MiniIconsAzure" },
    },
    lsp = {
      copilot = { glyph = "", hl = "MiniIconsOrange" },
    },
  },
  lazy = true,
  specs = {
    { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
  },
  init = function()
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
}
