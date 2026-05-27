local M = {}

function M.setup()
    require("conform").setup({
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "goimports", "gofmt" },
            php = { "pint" },
            javascript = { "prettier", "eslint_d" },
            javascriptreact = { "prettier", "eslint_d" },
            typescript = { "prettier", "eslint_d" },
            typescriptreact = { "prettier", "eslint_d" },
            vue = { "prettier", "eslint_d" },
            astro = { "prettier", "eslint_d" },
        },
        format_on_save = {
            timeout_ms = 1000,
            lsp_format = "fallback",
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
    })
end

return M
