local fn = require "utils.fn"
local opt = vim.opt
local o = vim.o
local g = vim.g

-- ─[ globals ]────────────────────────────────────────────────────────
g.mapleader = " "
g.maplocalleader = ","

-- ─[ options ]────────────────────────────────────────────────────────
opt.clipboard = "unnamedplus"
opt.cursorline = true

-- split
opt.splitkeep = "screen"

-- indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

 -- numbers
 o.number = true
 o.numberwidth = 2
 o.ruler = false
 o.rnu = true

-- disable nvim intro
opt.shortmess:append "sI"
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- diagnostic configurations
vim.diagnostic.config {
  signs = {
    [vim.diagnostic.severity.ERROR] = "",
    [vim.diagnostic.severity.WARN] = "",
    [vim.diagnostic.severity.INFO] = "",
    [vim.diagnostic.severity.HINT] = "",
  },
  virtual_text = false,
}

local severities = { "Error", "Warn", "Info", "Hint" }
for _, type in pairs(severities) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = "", texthl = hl, numhl = hl })
end

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (fn.is_win and ";" or ":") .. vim.env.PATH

-- shell configuration
if fn.is_win then
  opt.fileformats = { "unix", "dos" }
  vim.o.shellslash = true
  local powershell_options = {
    shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
    shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
  }

  for option, value in pairs(powershell_options) do
    opt[option] = value
  end
end

-- add filetype handlings
vim.filetype.add {
  extension = {
    mdx = "mdx",
    xaml = "xml",
  },
  pattern = {
    ["*.user.css"] = "less",
  },
}
