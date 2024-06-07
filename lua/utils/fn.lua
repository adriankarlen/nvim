local M = {}
local fn = vim.fn

M.get_cs_debug_dll = function()
  -- Get the project path from the user
  local project_path = fn.input("Project: ", fn.getcwd(), "file")

  -- Extract the project name from the path
  local project_name = project_path:match "([^/]+)/?$"

  -- Construct the path to the .csproj file
  local csproj_path = project_path .. project_name .. ".csproj"

  -- check if the file exists
  if os.rename(csproj_path, csproj_path) == nil then
    return fn.input("Path to dll: ", project_path .. "/bin/Debug/", "file")
  end
  -- Open the .csproj file and extract the target framework
  local csproj_file = io.open(csproj_path):read "*a"
  local target_framework = csproj_file:match "<TargetFramework>(.+)</TargetFramework>"

  -- Construct the path to the .dll file
  local dll_path = project_path .. "/bin/Debug/" .. target_framework .. "/" .. project_name .. ".dll"

  if not os.rename(dll_path, dll_path) then
    return fn.input("Path to dll: ", project_path .. "/bin/Debug/", "file")
  end
  return dll_path
end

return M
