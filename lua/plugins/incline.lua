return {
  "b0o/incline.nvim",
  config = function()
    local incline = require "incline"
    local palette = require "rose-pine.palette"
    local git_diff_color_map = {
      removed = palette.love,
      changed = palette.rose,
      added = palette.foam,
    }


    incline.setup {
      hide = {
        cursorline = true,
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)

        local get_git_diff = function()
          local icons = { removed = "-", changed = "~", added = "+" }
          local signs = vim.b[props.buf].gitsigns_status_dict
          local labels = {}
          if signs == nil then
            return labels
          end
          for name, icon in pairs(icons) do
            if tonumber(signs[name]) and signs[name] > 0 then
              table.insert(labels, { icon .. signs[name] .. " ", guifg = git_diff_color_map[name] })
            end
          end
          return labels
        end

        local get_diagnostic_label = function()
          local icons = { error = "", warn = "", info = "", hint = "" }

          local label = {}
          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
            if n > 0 then
              table.insert(label, { icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
            end
          end
          return label
        end

        local get_file_name = function()
          local label = {}
          table.insert(label, { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" })
          table.insert(label, { vim.bo[props.buf].modified and " " or "", guifg = palette.gold })
          table.insert(label, { filename, gui = "bold" })
          if not props.focused then
            label["group"] = "BufferInactive"
          end

          return label
        end

        local diagnostics = get_diagnostic_label()
        local diff = get_git_diff()
        local file_name = get_file_name()
        local buffer = {
          { diagnostics },
          { (#diagnostics > 0 and #diff > 0) and " | " or "" },
          { diff },
          { (#diagnostics > 0 or #diff > 0) and " | " or "" },
          { file_name },
        }
        return buffer
      end,
    }
  end,
  event = { "BufEnter" },
}
