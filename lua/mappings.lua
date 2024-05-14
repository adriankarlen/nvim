local map = vim.keymap
-- go to beginning and end
map.set("i", "<C-b>", "<esc>^i", { desc = "go to beginning of line" })
map.set("i", "<C-e>", "<end>", { desc = "go to end of line" })

-- navigate within insert mode using ctrl
map.set("i", "<C-h>", "<C-w>h", { desc = "move left in insert mode" })
map.set("i", "<C-j>", "<C-w>j", { desc = "move down in insert mode" })
map.set("i", "<C-l>", "<C-w>l", { desc = "move right in insert mode" })
map.set("i", "<C-k>", "<C-w>k", { desc = "move up in insert mode" })

map.set("n", "<esc>", "<cmd> noh <cr>", { silent = true, desc = "clear search highlight" })

-- switch between windows
map.set("n", "<C-h>", "<C-w>h", { desc = "move to left window" })
map.set("n", "<C-j>", "<C-w>j", { desc = "move to lower window" })
map.set("n", "<C-k>", "<C-w>k", { desc = "move to upper window" })
map.set("n", "<C-l>", "<C-w>l", { desc = "move to right window" })

-- save
map.set("n", "<C-s>", "<cmd> w <cr>", { desc = "save current file" })

-- copy all
map.set("n", "<C-c>", "<cmd> %y+ <cr>", { desc = "copy all to clipboard" })

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
map.set(
  { "n", "v" },
  "j",
  'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
  { expr = true, desc = "move down through wrapped lines" }
)
map.set(
  { "n", "v" },
  "k",
  'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
  { expr = true, desc = "move up through wrapped lines" }
)
map.set(
  { "n", "v" },
  "<up>",
  'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
  { expr = true, desc = "move up through wrapped lines" }
)
map.set(
  { "n", "v" },
  "<down>",
  'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
  { expr = true, desc = "move down through wrapped lines" }
)

-- buffer management
map.set("n", "<leader>bn", "<cmd> enew <cr>", { desc = "create new buffer" })
map.set("n", "<leader>x", "<cmd> bd <cr>", { desc = "delete current buffer" })
-- switch between buffers
map.set("n", "<Tab>", "<cmd> bn <cr>", { desc = "switch to next buffer" })
map.set("n", "<S-Tab>", "<cmd> bp <cr>", { desc = "switch to previous buffer" })

-- format
map.set("n", "<leader>fm", function()
  vim.lsp.buf.format { async = true }
end, { desc = "format current buffer" })

-- indent line
map.set("v", "<", "<gv", { desc = "indent line to the left" })
map.set("v", ">", ">gv", { desc = "indent line to the right" })

-- paste without copying
map.set("x", "p", 'p:let @+=@0<cr>:let @"=@0<cr>', { desc = "paste without copying" })

-- simpler movement on nordic keyboards
map.set("n", ";", ":", { desc = "replace semicolon with colon" })
map.set("n", "å", "\\", { desc = "replace ä with backslash" })
map.set({ "n", "v" }, "*", '"', { desc = "replace * with double quote" })
map.set("n", "ö", "[", { desc = "replace å with left bracket" })
map.set("n", "ä", "]", { desc = "replace ¨ with right bracket" })
map.set({ "n", "v" }, "Ö", "{", { desc = "replace Ö with left curly brace" })
map.set({ "n", "v" }, "Ä", "}", { desc = "replace Ä with right curly brace" })
map.set({ "c", "n", "v" }, "&", "^", { desc = "replace & with caret" })
map.set({ "c", "n", "v" }, "¤", "$", { desc = "replace ¤ with dollar sign" })
map.set("n", "§", "`", { desc = "replace § with backtick" })

-- capitalize word in insert mode
map.set("i", "GG", "<esc>bgUiwea", { desc = "make word uppercase"})

-- comment
map.set("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "toggle comment on current line" })
map.set(
  "v",
  "<leader>/",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "toggle comment on selected lines" }
)
