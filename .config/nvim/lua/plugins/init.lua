local M = {}

function M.setup()
    --------------------------------------------------------------------------
    -- Immediate plugins (loaded at startup)
    --------------------------------------------------------------------------
    vim.cmd.packadd("teide.nvim")
    vim.cmd.packadd("snacks.nvim")
    vim.cmd.packadd("which-key.nvim")
    vim.cmd.packadd("lualine.nvim")
    vim.cmd.packadd("nvim-treesitter")
    vim.cmd.packadd("nvim-lspconfig")
    vim.cmd.packadd("friendly-snippets")
    vim.cmd.packadd("blink.lib")
    vim.cmd.packadd("blink.cmp")
    vim.cmd.packadd("mason.nvim")
    vim.cmd.packadd("oil.nvim")
    vim.cmd.packadd("render-markdown.nvim")
    vim.cmd.packadd("no-neck-pain.nvim")

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
            vim.cmd.packadd("gitsigns.nvim")
            vim.cmd.packadd("todo-comments.nvim")
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
            vim.cmd.packadd("conform.nvim")
            require("plugins.conform").setup()
            require("conform").format({ lsp_format = "fallback", buf = ev.buf })
        end,
    })

    -- Autotag: load on first insert
    vim.api.nvim_create_autocmd("InsertEnter", {
        once = true,
        callback = function()
            vim.cmd.packadd("nvim-ts-autotag")
            require("plugins.autotag").setup()
        end,
    })

    -- Ledger: load on ledger filetype
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "ledger",
        once = true,
        callback = function()
            vim.cmd.packadd("ledger.nvim")
            require("plugins.ledger").setup()
            vim.cmd.packadd("blink.compat")
            vim.cmd.packadd("wllfaria-ledger.nvim")
            require("plugins.wllfaria-ledger").setup()
        end,
    })

    -- Inlinediff: load on first use
    local function ensure_inlinediff()
        if not package.loaded["inlinediff"] then
            vim.cmd.packadd("inlinediff-nvim")
            require("plugins.inlinediff").setup()
        end
        return require("inlinediff")
    end

    vim.keymap.set("n", "<leader>gD", function()
        ensure_inlinediff().toggle()
    end, { desc = "Toggle Inline Diff" })
end

return M
