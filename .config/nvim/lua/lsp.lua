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

    vim.lsp.config("vtsls", {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
        on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end,
    })

    vim.lsp.config("intelephense", {
        settings = {
            intelephense = {
                files = {
                    exclude = {
                        "**/tests/src/**",
                        "**/tests/packages/**",
                    },
                },
            },
        },
    })

    vim.lsp.enable({
        "lua_ls",

        "vtsls", "vue_ls",
        "astro", "eslint",
        "emmet_language_server",
        "tailwindcss",
        "html",

        "gopls",
        "templ",

        "intelephense",

        "sqls",
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            if client and client:supports_method("textDocument/foldingRange") then
                local win = vim.api.nvim_get_current_win()
                vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
            end
        end,
    })

    vim.diagnostic.config({
        virtual_text = true,
    })
end

return M
