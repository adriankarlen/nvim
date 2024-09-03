local M = {}

local get_all_csproj = function()
  local scandir = require "plenary.scandir"
  local result = {}
  local cwd = vim.fn.getcwd():gsub("\\", "/")
  local csproj_files = scandir.scan_dir(cwd, {
    hidden = false, -- Include hidden files (those starting with .)
    only_dirs = false, -- Include both files and directories
    depth = 5, -- Set the depth of search
    search_pattern = "%.csproj$", -- Lua pattern to match .csproj files
  })

  if csproj_files == nil then
    error "No csproj files found"
  end
  for _, value in ipairs(csproj_files) do
    local path = value:gsub("\\", "/")
    table.insert(result, path)
  end
  return result
end

local check_csproj = function(csproj)
  if csproj and csproj:match "%.csproj" then
    return true
  end
  return false
end

local execute = function(cmd, display_name)
  local toggleterm = require "toggleterm.terminal"
  local all_csproj = get_all_csproj()
  if vim.g.dotnet_utils.last_used_csproj == nil then
    vim.ui.select(all_csproj, {
      prompt = "Select a project:",
      format_item = function(item)
        local icon, _, _ = require("mini.icons").get("file", vim.fs.basename(item))
        -- TODO: add hl group
        return icon .. " " .. item
      end,
    }, function(choice)
      if not check_csproj(choice) then
        error "Invalid csproj path"
      end
      vim.g.dotnet_utils.last_used_csproj = choice
      vim.g.dotnet_utils.watch_is_running = true

      local command = toggleterm.Terminal:new {
        cmd = cmd .. choice,
        display_name = display_name,
        close_on_exit = close_on_exit,
        direction = "float",
      }
      command:toggle()
    end)
  else
    local command = toggleterm.Terminal:new {
      cmd = cmd .. vim.g.dotnet_utils.last_used_csproj,
      display_name = display_name,
      close_on_exit = true,
      direction = "float",
    }
    command:toggle()
  end
end

M.build = function()
  execute("dotnet build ", "dotnet build")
end

M.watch = function()
  execute("dotnet watch --project ", "dotnet watch")
end

M.setup = function()
  vim.g.dotnet_utils = {
    last_used_csproj = nil,
    watch_is_running = false,
  }
  -- stylua: ignore start 
  vim.keymap.set("n", "<leader>nw", function () M.watch() end, { desc = "watch project", noremap = true })
  vim.keymap.set("n", "<leader>nb", function () M.build() end, { desc = "build project", noremap = true })
  -- stylua: ignore end
end

return M
