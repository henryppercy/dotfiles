return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "goimports", "gofmt" },
            php = { "pint" },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
    },
}
