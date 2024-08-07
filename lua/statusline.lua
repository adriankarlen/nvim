local M = {}

local function _spacer(n)
  local spaces = string.rep(" ", n)
  return "%#StatuslineTextMain#" .. spaces
end

local function _align()
  return "%="
end

local function _truncate()
  return "%<"
end

-- From TJDevries
-- https://github.com/tjdevries/lazy-require.nvim
local function lazy_require(require_path)
    return setmetatable({}, {
        __index = function(_, key)
            return require(require_path)[key]
        end,

        __newindex = function(_, key, value)
            require(require_path)[key] = value
        end,
    })
end

local function mode_color()
  local current_mode = vim.api.nvim_get_mode().mode
  local higroup = "%#StatuslineModeCommand#"
  if current_mode == "n" then
    higroup = "%#StatuslineModeNormal#"
  elseif current_mode == "i" or current_mode == "ic" then
    higroup = "%#StatuslineModeInsert#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
    higroup = "%#StatuslineModeVisual#"
  elseif current_mode == "R" or current_mode == "Rv" then
    higroup = "%#StatuslineModeReplace#"
  elseif current_mode == "s" or current_mode == "S" or current_mode == "" then
    higroup = "%#StatuslineModeSelect#"
  elseif current_mode == "c" then
    higroup = "%#StatuslineModeCommand#"
  end
  return higroup
end

local function get_mode()
  local modes = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["v"] = "VISUAL",
    ["V"] = "V-LINE",
    [""] = "V-BLOCK",
    ["s"] = "SELECT",
    ["S"] = "S-LINE",
    [""] = "S-BLOCK",
    ["R"] = "REPLACE",
    ["Rv"] = "V-REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
    ["niI"] = "INS-NOR",
  }
  local current_mode = vim.api.nvim_get_mode().mode
  local value = ""
  if modes[current_mode] == nil then
    value = "UNKNOWN"
  else
    value = modes[current_mode]
  end
  return mode_color() .. " " .. value .. " " .. _spacer(0)
end

local function get_path()
  local path = vim.fn.expand "%:~:.:h"
  local higroup = "%#StatuslineTextAccent#"
  local max_width = 30
  if path == "." or path == "" then
    return ""
  elseif #path > max_width then
    path = "…" .. string.sub(path, -max_width + 2)
  end
  return _spacer(1) .. higroup .. path .. "/"
end

local function get_filename()
  local filename = vim.fn.expand "%:~:t"
  local path = vim.fn.expand "%:~:.:h"
  local higroup = "%#StatuslineTextMain#"
  if filename == "" then
    return _spacer(1) .. higroup .. "[No Name]"
  end
  if path == "." then
    return _spacer(1) .. higroup .. filename
  end
  return higroup .. filename
end

local function get_modification_status()
  local buf_modified = vim.bo.modified
  local buf_modifiable = vim.bo.modifiable
  local buf_readonly = vim.bo.readonly
  local hi_notsaved = "%#StatuslineNotSaved#"
  local hi_readonly = "%#StatuslineReadOnly#"
  if buf_modified then
    return hi_notsaved .. " • "
  elseif buf_modifiable == false or buf_readonly == true then
    return hi_readonly .. " • "
  else
    return ""
  end
end

local function get_lsp_status()
  local clients = vim.lsp.get_clients { bufnr = 0 }
  local higroup = "%#StatuslineLspOn#"
  if #clients > 0 and clients[1].initialized then
    return higroup .. "  " .. _spacer(0)
  else
    return ""
  end
end

local function get_formatter_status()
  local higroup = "%#StatuslineFormatterStatus#"
  local conform = lazy_require("conform")

  local formatters = conform.list_formatters(0)
  if #formatters > 0 then
    return higroup .. "  " .. _spacer(0)
  else
    return ""
  end
end

local function get_copilot_status()
  local hi_copilot = "%#StatuslineCopilot#"
  local c = lazy_require("copilot.client")
  local ok = not c.is_disabled() and c.buf_is_attached(vim.api.nvim_get_current_buf())
  if not ok then
    return ""
  end
  return hi_copilot .. "  " .. _spacer(0)
end

local function get_diagnostics()
  local count_error = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local count_warning = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local count_info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  local count_hint = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  local diag_count = 0
  local higroup_error = "%#StatuslineLspError#"
  local higroup_warning = "%#StatuslineLspWarning#"

  local higroup_info = "%#StatuslineLspInfo#"
  local higroup_hint = "%#StatuslineLspHint#"
  local error, warning, info, hint = "", "", "", ""
  if count_error == 0 then
    error = ""
  else
    error = higroup_error .. "• " .. count_error .. _spacer(1)
  end
  if count_warning == 0 then
    warning = ""
  else
    warning = higroup_warning .. "• " .. count_warning .. _spacer(1)
  end
  if count_info == 0 then
    info = ""
  else
    info = higroup_info .. "• " .. count_info .. _spacer(1)
  end
  if count_hint == 0 then
    hint = ""
  else
    hint = higroup_hint .. "• " .. count_hint .. _spacer(1)
  end
  if count_error + count_warning + count_info + count_hint == 0 then
    diag_count = 0
  else
    diag_count = 1
  end
  return error .. warning .. info .. hint .. _spacer(diag_count)
end

local function get_branch()
  local branch = vim.fn.FugitiveHead()
  local higroup_main = "%#StatuslineTextMain#"
  local higroup_accent = "%#StatuslineTextAccent#"
  if branch == "" then
    return ""
  end
  return higroup_accent .. " " .. higroup_main .. branch .. _spacer(2)
end

local function get_recording()
  local higroup_main = "%#StatuslineTextMain#"
  local higroup_accent = "%#StatuslineTextAccent#"
  local recorder = lazy_require("recorder")
  local status = recorder.recordingStatus()
  if status == "" then
    return ""
  end
  return higroup_accent .. " " .. higroup_main .. recorder.recordingStatus() .._spacer(2)
end

local function get_macro_slots()
  local higroup_main = "%#StatuslineTextMain#"
  local higroup_accent = "%#StatuslineTextAccent#"
  local recorder = lazy_require("recorder")
  local display_slots = recorder.displaySlots()

  if display_slots == "" then
    return ""
  end

  return higroup_accent .. " " .. higroup_main .. display_slots .. _spacer(2)

end

local function get_percentage()
  local current_line = vim.fn.line "."
  local total_lines = vim.fn.line "$"
  local percent = vim.fn.floor(current_line / total_lines * 100)
  local content = ""
  local higroup_bold = "%#StatuslineTextBold#"
  local higroup_accent = "%#StatuslineTextAccent#"
  if current_line == 1 then
    content = "TOP"
  elseif current_line == total_lines then
    content = "END"
  elseif percent < 10 then
    content = higroup_accent .. "·" .. higroup_bold .. percent .. "%%"
  else
    content = percent .. "%%"
  end
  return higroup_accent .. "≡ " .. higroup_bold .. content .. _spacer(2)
end

local function get_filetype()
  local higroup = "%#StatuslineFiletype#"
  local ft = vim.bo.filetype:upper()
  if ft == "" then
    return higroup .. "-" .. _spacer(2)
  else
    return higroup .. ft .. _spacer(2)
  end
end

M.load = function()
  return table.concat {
    get_mode(),
    get_path(),
    get_filename(),
    get_modification_status(),
    get_lsp_status(),
    get_formatter_status(),
    get_copilot_status(),
    _spacer(2),
    _align(),
    get_diagnostics(),
    get_recording(),
    get_macro_slots(),
    get_branch(),
    get_percentage(),
    get_filetype(),
    _truncate(),
  }
end

vim.api.nvim_create_augroup("Statusline", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = "Statusline",
  pattern = "*",
  callback = function()
    vim.o.statusline = "%!v:lua.require'statusline'.load()"
  end,
})

return M
