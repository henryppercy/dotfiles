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
        on_init = function(client)
            local ok, blink = pcall(require, "blink.cmp")
            if ok then
                client.capabilities = blink.get_lsp_capabilities(client.capabilities)
            end
        end,
        root_markers = { ".git" },
    })

    vim.lsp.enable({
        "lua_ls",
        "vtsls",
        "gopls",
        "vue_ls",
        "astro",
        "emmet_language_server",
    })

    vim.diagnostic.config({
        virtual_text = true, -- always show virtual line diagnostic
    })

    -- native autocomplete

    -- don't auto select first option
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
