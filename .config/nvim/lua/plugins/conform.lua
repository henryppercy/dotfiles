local M = {}

function M.setup()
    require("conform").setup({
        formatters_by_ft = {
            astro = { "prettier", "eslint_d" },
            go = { "goimports", "gofmt" },
            javascript = { "prettier", "eslint_d" },
            javascriptreact = { "prettier", "eslint_d" },
            lua = { "stylua" },
            php = { "pint" },
            typescript = { "prettier", "eslint_d" },
            typescriptreact = { "prettier", "eslint_d" },
            vue = { "prettier", "eslint_d" },
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
