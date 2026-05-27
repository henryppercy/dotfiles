local M = {}

function M.setup()
    --------------------------------------------------------------------------
    -- Build hooks (must be registered before vim.pack.add)
    --------------------------------------------------------------------------
    vim.api.nvim_create_autocmd("PackChanged", {
        callback = function(ev)
            if ev.data.spec.name == "nvim-treesitter" and ev.data.kind ~= "delete" then
                if not ev.data.active then
                    vim.cmd.packadd("nvim-treesitter")
                end
                vim.cmd("TSUpdate")
            end
        end,
    })

    --------------------------------------------------------------------------
    -- Immediate plugins (loaded at startup)
    --------------------------------------------------------------------------
    vim.pack.add({
        -- Colorscheme (must be first)
        "https://github.com/serhez/teide.nvim",

        -- UI
        "https://github.com/folke/snacks.nvim",
        "https://github.com/folke/which-key.nvim",
        "https://github.com/nvim-lualine/lualine.nvim",

        -- Treesitter
        "https://github.com/nvim-treesitter/nvim-treesitter",

        -- LSP server configs
        "https://github.com/neovim/nvim-lspconfig",

        -- Completion (dependency first)
        "https://github.com/rafamadriz/friendly-snippets",
        { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },

        -- Tools
        "https://github.com/williamboman/mason.nvim",
        "https://github.com/stevearc/oil.nvim",
        "https://github.com/MeanderingProgrammer/render-markdown.nvim",
        "https://github.com/shortcuts/no-neck-pain.nvim",
    })

    -- Configure in load order
    require("plugins.teide").setup()
    require("plugins.snacks").setup()
    require("plugins.which-key").setup()
    require("plugins.lualine").setup()
    require("plugins.treesitter").setup()
    require("plugins.blink-cmp").setup()
    require("plugins.mason").setup()
    require("plugins.oil").setup()
    require("plugins.render-markdown").setup()
    require("plugins.no-neck-pain").setup()

    --------------------------------------------------------------------------
    -- Deferred plugins (load after first buffer)
    --------------------------------------------------------------------------
    vim.api.nvim_create_autocmd("BufReadPost", {
        once = true,
        callback = function()
            vim.pack.add({
                "https://github.com/lewis6991/gitsigns.nvim",
                "https://github.com/folke/todo-comments.nvim",
            })
            require("plugins.gitsigns").setup()
            require("plugins.todo-comments").setup()
        end,
    })

    --------------------------------------------------------------------------
    -- Lazy plugins (load on event/command)
    --------------------------------------------------------------------------

    -- Conform: load on first save
    vim.api.nvim_create_autocmd("BufWritePre", {
        once = true,
        callback = function(ev)
            vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
            require("plugins.conform").setup()
            require("conform").format({ lsp_format = "fallback", buf = ev.buf })
        end,
    })

    -- Autotag: load on first insert
    vim.api.nvim_create_autocmd("InsertEnter", {
        once = true,
        callback = function()
            vim.pack.add({ "https://github.com/windwp/nvim-ts-autotag" })
            require("plugins.autotag").setup()
        end,
    })

    -- Inlinediff: load on first use
    local function ensure_inlinediff()
        if not package.loaded["inlinediff"] then
            vim.pack.add({ "https://github.com/YouSame2/inlinediff-nvim" })
            require("plugins.inlinediff").setup()
        end
        return require("inlinediff")
    end

    vim.keymap.set("n", "<leader>gD", function()
        ensure_inlinediff().toggle()
    end, { desc = "Toggle Inline Diff" })
end

return M
