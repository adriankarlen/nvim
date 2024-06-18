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
          return label
        end

        local diagnostics = get_diagnostic_label()
        local diff = get_git_diff()
        local separator = (#diagnostics > 0 and #diff > 0) and " | " or ""
        local buffer = {
          { diagnostics },
          { separator },
          { diff },
        }
        return buffer
      end,
    }
  end,
  event = { "BufEnter" },
}
