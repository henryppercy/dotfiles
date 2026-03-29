local M = {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
}

function M.init()
    require("mappings").register({ "<leader>It", "<cmd>TSUpdate<cr>", desc = "Update parsers" })
    require("mappings").register({ "<leader>IT", "<cmd>TSInstall all<cr>", desc = "Install parsers (all)" })
end

function M.config()
    vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
            local buf = args.buf
            local filetype = args.match

            -- Check if a parser exists for the current language
            local language = vim.treesitter.language.get_lang(filetype) or filetype
            if not vim.treesitter.language.add(language) then
                return
            end

            -- Highlighting
            vim.treesitter.start(buf, language)

            -- Indentation
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
    })
end

return M
