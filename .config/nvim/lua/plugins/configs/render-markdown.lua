return {
    'MeanderingProgrammer/render-markdown.nvim',
    ---@module 'render-markdown'
    opts = {
        sign = {
            enabled = false
        },

        link = {
            enabled = false,
        },

        heading = {
            icons = { "", "", "", "", "", "" },
            width = "block",

            position = "inline",
            left_pad = 1,
            right_pad = 1,
        },
        bullet = {
            icons = { "•", "•", "•", "•" },
        },
        checkbox = {
            checked = { icon = "󰄮" },
            unchecked = { icon = "" },
            custom = {
                cancelled = {
                    raw = '[-]',
                    rendered = '',
                    highlight = 'RenderMarkdownCancelled',
                    scope_highlight = 'RenderMarkdownCancelledScope',
                },
            },
        },
    },
}
