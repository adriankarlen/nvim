return {
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = "rafamadriz/friendly-snippets",
    version = "v0.*",
    opts = {
      nerd_font_variant = "normal",
      windows = {
        autocomplete = {
          border = "single",
          -- draw = function(ctx)
          --   local MiniIcons = require "mini.icons"
          --   local source = ctx.item.source_name
          --   local label = ctx.item.label
          --   local icon = source == "LSP" and MiniIcons.get("lsp", ctx.kind)
          --     or source == "Path" and (label:match "%.[^/]+$" and MiniIcons.get("file", label) or MiniIcons.get(
          --       "directory",
          --       ctx.item.label
          --     ))
          --     or source == "codeium" and MiniIcons.get("lsp", "event")
          --     or ctx.kind_icon
          --   return {
          --     " ",
          --     { icon, ctx.icon_gap, hl_group = "BlinkCmpKind" .. ctx.kind },
          --     {
          --       ctx.label,
          --       ctx.kind == "Snippet" and "~" or "",
          --       (ctx.item.labelDetails and ctx.item.labelDetails.detail) and ctx.item.labelDetails.detail or "",
          --       fill = true,
          --       hl_group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
          --       max_width = 80,
          --     },
          --     " ",
          --   }
          -- end,
        },
      },
      opts_extend = { "sources.completion.enabled_providers" },
      sources = {
        completion = {
          enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
        },
        providers = {
          lsp = { fallback_for = { "lazydev" } },
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
        },
      },
    },
  },
}
