return {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
        progress = {
            display = {
                render_limit = 16, -- How many LSP messages to show at once
                done_ttl = 3, -- How long a message should persist after completion
                done_icon = "✔",
                progress_icon = { pattern = "meter", period = 1 },
            },
        },

        notification = {
            poll_rate = 60, -- FPS
            view = {
                stack_upwards = true,
                icon_separator = " ",
                group_separator = "---",
            },

            window = {
                normal_hl = "Comment", -- Base highlight group in the notification window
                winblend = 0, -- Background color opacity in the notification window
                border = "single", -- Border around the notification window
                x_padding = 1,
                y_padding = 0,
                relative = "editor",
            },
        },
    },
}
