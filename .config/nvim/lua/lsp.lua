local M = {}

function M.setup()
    vim.lsp.config("*", {
        capabilities = {
            textDocument = {
                semanticTokens = {
                    multilineTokenSupport = true,
                }
            }
        },
        root_markers = { ".git" },
    })

    vim.lsp.enable({
        "lua_ls", "ts_ls", "gopls",
    })

    vim.diagnostic.config({
        virtual_text = true, -- always show virtual line diagnostic
        -- virtual_lines = {
        --     current_line = true, -- only show virtual line diagnostics for the current cursor line
        -- },
    })

    -- configure autocomplete, don't auto select first option
    -- vim.opt.completeopt = { "menuone", "noselect", "popup" }

    -- enable autocomplete
    -- vim.api.nvim_create_autocmd("LspAttach", {
    --     callback = function(ev)
    --         local client = vim.lsp.get_client_by_id(ev.data.client_id)
    --         if client:supports_method("textDocument/completion") then
    --             vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    --         end
    --     end
    -- })
end

return M
