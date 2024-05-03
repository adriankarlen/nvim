local logo = {
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                     ]],
  [[       ████ ██████           █████      ██                     ]],
  [[      ███████████             █████                             ]],
  [[      █████████ ███████████████████ ███   ███████████   ]],
  [[     █████████  ███    █████████████ █████ ██████████████   ]],
  [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
  [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
  [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
}

return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
  },

  config = function()
    local alpha_th = require "alpha.themes.theta"
    local alpha_db = require "alpha.themes.dashboard"
    alpha_th.header.val = logo
    alpha_th.buttons.val = {
      {
        type = "text",
        val = "╭" .. string.rep("─", 48) .. "╮",
        opts = { hl = "FloatBorder", position = "center" },
      },
      alpha_db.button("i", "    new file", ":ene <BAR> startinsert<CR>"),
      alpha_db.button("o", "    old files", ":Telescope oldfiles<CR>"),
      alpha_db.button("f", "󰥨    find file", ":Telescope find_files<CR>"),
      alpha_db.button("w", "󰱼    find text", ":Telescope live_grep<CR>"),
      alpha_db.button("g", "    browse git", ":LazyGit<CR>"),
      alpha_db.button("l", "󰒲    lazy", ":Lazy<CR>"),
      alpha_db.button("m", "󱌣    mason", ":Mason<CR>"),
      alpha_db.button("p", "󰄉    profile", ":Lazy profile<CR>"),
      alpha_db.button("q", "󰭿    quit", ":qa<CR>"),
      {
        type = "text",
        val = "╰" .. string.rep("─", 48) .. "╯",
        opts = { hl = "FloatBorder", position = "center" },
      },
    }
    require("alpha").setup(alpha_th.config)
  end,
}
