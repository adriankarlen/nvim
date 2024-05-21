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
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)

        local function get_git_diff()
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
          if #labels > 0 then
            table.insert(labels, { "| " })
          end
          return labels
        end

        local function get_diagnostic_label()
          local icons = { error = "", warn = "", info = "", hint = "" }

          local label = {}
          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
            if n > 0 then
              table.insert(label, { icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
            end
          end
          if #label > 0 then
            table.insert(label, { "| " })
          end
          return label
        end

        local function get_file_name()
          local label = {}
          table.insert(label, { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" })
          table.insert(label, { vim.bo[props.buf].modified and " " or "", guifg = palette.gold })
          table.insert(label, { filename, gui = "bold" })
          if not props.focused then
            label["group"] = "BufferInactive"
          end

          return label
        end

        local buffer = {
          { get_diagnostic_label() },
          { get_git_diff() },
          { get_file_name() },
        }
        return buffer
      end,
    }
  end,
  event = "VeryLazy",
}
