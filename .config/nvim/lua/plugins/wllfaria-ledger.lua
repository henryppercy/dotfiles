local M = {}

function M.setup()
    require("ledger").setup({
        completion = {
            cmp = { enabled = true },
        },
        snippets = {
            cmp    = { enabled = true },
            native = { enabled = false },
        },
        diagnostics = {
            lsp_diagnostics = true,
            strict = false,
        },
        keymaps = {
            snippets = {
                new_posting       = { "tt" },
                new_account       = { "acc" },
                new_posting_today = { "td" },
                new_commodity     = { "cm" },
            },
            reports = {},
        },
    })
end

return M
