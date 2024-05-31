return {
  "echasnovski/mini.files",
  version = false,
  config = function()
    require("mini.files").setup {
      mappings = {
        go_in_plus = "<tab>",
        go_out_plus = "<s-tab>",
      },
    }
    local nsMiniFiles = vim.api.nvim_create_namespace "mini_files_git"
    local autocmd = vim.api.nvim_create_autocmd
    local _, MiniFiles = pcall(require, "mini.files")

    -- Cache for git status
    local gitStatusCache = {}
    local cacheTimeout = 2000 -- Cache timeout in milliseconds

    local function mapSymbols(status)
      local statusMap = {
          -- stylua: ignore start 
          [" M"] = { symbol = "•", hlGroup  = "MiniDiffSignChange"}, -- Modified in the working directory
          ["M "] = { symbol = "✹", hlGroup  = "MiniDiffSignChange"}, -- modified in index
          ["MM"] = { symbol = "≠", hlGroup  = "MiniDiffSignChange"}, -- modified in both working tree and index
          ["A "] = { symbol = "+", hlGroup  = "MiniDiffSignAdd"   }, -- Added to the staging area, new file
          ["AA"] = { symbol = "≈", hlGroup  = "MiniDiffSignAdd"   }, -- file is added in both working tree and index
          ["D "] = { symbol = "-", hlGroup  = "MiniDiffSignDelete"}, -- Deleted from the staging area
          ["AM"] = { symbol = "⊕", hlGroup  = "MiniDiffSignChange"}, -- added in working tree, modified in index
          ["AD"] = { symbol = "-•", hlGroup = "MiniDiffSignChange"}, -- Added in the index and deleted in the working directory
          ["R "] = { symbol = "→", hlGroup  = "MiniDiffSignChange"}, -- Renamed in the index
          ["U "] = { symbol = "‖", hlGroup  = "MiniDiffSignChange"}, -- Unmerged path
          ["UU"] = { symbol = "⇄", hlGroup  = "MiniDiffSignAdd"   }, -- file is unmerged
          ["UA"] = { symbol = "⊕", hlGroup  = "MiniDiffSignAdd"   }, -- file is unmerged and added in working tree
          ["??"] = { symbol = "?", hlGroup  = "MiniDiffSignDelete"}, -- Untracked files
          ["!!"] = { symbol = "!", hlGroup  = "MiniDiffSignChange"}, -- Ignored files
        -- stylua: ignore end
      }

      local result = statusMap[status] or { symbol = "?", hlGroup = "NonText" }
      return result.symbol, result.hlGroup
    end

    local function fetchGitStatus(cwd, callback)
      local stdout = (vim.uv or vim.loop).new_pipe(false)
      _, _ = (vim.uv or vim.loop).spawn(
        "git",
        {
          args = { "status", "--ignored", "--porcelain" },
          cwd = cwd,
          stdio = { nil, stdout, nil },
        },
        vim.schedule_wrap(function(code, _)
          if code == 0 then
            stdout:read_start(function(_, content)
              if content then
                callback(content)
                vim.g.content = content
              end
              stdout:close()
            end)
          else
            vim.notify("Git command failed with exit code: " .. code, vim.log.levels.ERROR)
            stdout:close()
          end
        end)
      )
    end

    local function escapePattern(str)
      return str:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
    end

    local function updateMiniWithGit(buf_id, gitStatusMap)
      vim.schedule(function()
        local nlines = vim.api.nvim_buf_line_count(buf_id)
        local cwd = vim.fn.getcwd() --  vim.fn.expand("%:p:h")
        local escapedcwd = escapePattern(cwd)
        if vim.fn.has "win32" == 1 then
          escapedcwd = escapedcwd:gsub("\\", "/")
        end

        for i = 1, nlines do
          local entry = MiniFiles.get_fs_entry(buf_id, i)
          if not entry then
            break
          end
          local relativePath = entry.path:gsub("^" .. escapedcwd .. "/", "")
          local status = gitStatusMap[relativePath]

          if status then
            local symbol, hlGroup = mapSymbols(status)
            vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, 0, {
              -- NOTE: if you want the signs on the right uncomment those and comment
              -- the 3 lines after
              -- virt_text = { { symbol, hlGroup } },
              -- virt_text_pos = "right_align",
              sign_text = symbol,
              sign_hl_group = hlGroup,
              priority = 2,
            })
          else
          end
        end
      end)
    end

    local function is_valid_git_repo()
      if vim.fn.isdirectory ".git" == 0 then
        return false
      end
      return true
    end

    -- Thanks for the idea of gettings https://github.com/refractalize/oil-git-status.nvim signs for dirs
    local function parseGitStatus(content)
      local gitStatusMap = {}
      -- lua match is faster than vim.split (in my experience )
      for line in content:gmatch "[^\r\n]+" do
        local status, filePath = string.match(line, "^(..)%s+(.*)")
        -- Split the file path into parts
        local parts = {}
        for part in filePath:gmatch "[^/]+" do
          table.insert(parts, part)
        end
        -- Start with the root directory
        local currentKey = ""
        for i, part in ipairs(parts) do
          if i > 1 then
            -- Concatenate parts with a separator to create a unique key
            currentKey = currentKey .. "/" .. part
          else
            currentKey = part
          end
          -- If it's the last part, it's a file, so add it with its status
          if i == #parts then
            gitStatusMap[currentKey] = status
          else
            -- If it's not the last part, it's a directory. Check if it exists, if not, add it.
            if not gitStatusMap[currentKey] then
              gitStatusMap[currentKey] = status
            end
          end
        end
      end
      return gitStatusMap
    end

    local function updateGitStatus(buf_id)
      if not is_valid_git_repo() then
        return
      end
      local cwd = vim.fn.expand "%:p:h"
      local currentTime = os.time()
      if gitStatusCache[cwd] and currentTime - gitStatusCache[cwd].time < cacheTimeout then
        updateMiniWithGit(buf_id, gitStatusCache[cwd].statusMap)
      else
        fetchGitStatus(cwd, function(content)
          local gitStatusMap = parseGitStatus(content)
          gitStatusCache[cwd] = {
            time = currentTime,
            statusMap = gitStatusMap,
          }
          updateMiniWithGit(buf_id, gitStatusMap)
        end)
      end
    end

    local function clearCache()
      gitStatusCache = {}
    end

    local function augroup(name)
      return vim.api.nvim_create_augroup("MiniFiles_" .. name, { clear = true })
    end

    local show_git_dir = false
    local filter_show = function(_)
      return true
    end

    local filter_hide = function(fs_entry)
      return fs_entry.path:sub(-4) ~= ".git"
    end

    local apply_filter = function(filter)
      MiniFiles.refresh { content = { filter = filter } }
    end

    local toggle_git_dir_hide = function()
      show_git_dir = not show_git_dir
      local filter = show_git_dir and filter_show or filter_hide
      apply_filter(filter)
    end

    autocmd("User", {
      group = augroup "start",
      pattern = "MiniFilesExplorerOpen",
      -- pattern = { "minifiles" },
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        updateGitStatus(bufnr)
        local filter = show_git_dir and filter_show or filter_hide
        apply_filter(filter)
      end,
    })

    autocmd("User", {
      group = augroup "close",
      pattern = "MiniFilesExplorerClose",
      callback = function()
        clearCache()
      end,
    })

    autocmd("User", {
      group = augroup "update",
      pattern = "MiniFilesBufferUpdate",
      callback = function(sii)
        local bufnr = sii.data.buf_id
        local cwd = vim.fn.expand "%:p:h"
        if gitStatusCache[cwd] then
          updateMiniWithGit(bufnr, gitStatusCache[cwd].statusMap)
        end
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak left-hand side of mapping to your liking
        vim.keymap.set("n", "g.", toggle_git_dir_hide, { buffer = buf_id })
      end,
    })
  end,
  keys = {
    {
      "<leader>e",
      function()
        local _ = require("mini.files").close() or require("mini.files").open()
      end,
      { desc = "file explorer", noremap = true, silent = true },
    },
    {
      "-",
      function()
        local current_file = vim.fn.expand "%"
        local _ = require("mini.files").close() or require("mini.files").open(current_file, false)
        vim.schedule(function()
          vim.defer_fn(function()
            vim.cmd "normal @"
          end, 10)
        end)
      end,
    },
  },
}
