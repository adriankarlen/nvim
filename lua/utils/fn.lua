local M = {}
local uv = vim.loop

M.is_win = function()
  uv.os_uname().version:match "Windows"
end

return M
