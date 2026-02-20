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

        "gopls",

        "intelephense",
    })

    vim.diagnostic.config({
        virtual_text = true,
    })
end

return M
