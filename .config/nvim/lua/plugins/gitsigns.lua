local M = {}

function M.setup()
    local colors = require("teide.colors").setup()

    require("gitsigns").setup({
        current_line_blame = true,
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "" },
            topdelete = { text = "" },
            changedelete = { text = "▎" },
            untracked = { text = "┆" },
        },
        signs_staged = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "" },
            topdelete = { text = "" },
            changedelete = { text = "▎" },
            untracked = { text = "┆" },
        },
        on_attach = function(bufnr)
            local gs = require("gitsigns")
            local register = require("mappings").register

            register({
                { "]h",         function() gs.nav_hunk("next") end, desc = "Next Hunk",    buffer = bufnr },
                { "[h",         function() gs.nav_hunk("prev") end, desc = "Prev Hunk",    buffer = bufnr },
                { "<leader>gp", gs.preview_hunk,                    desc = "Preview Hunk", buffer = bufnr },
                { "<leader>gr", gs.reset_hunk,                       desc = "Revert Hunk",  buffer = bufnr },
                { "<leader>gB", gs.toggle_current_line_blame,       desc = "Toggle Blame", buffer = bufnr },
            })
        end,
    })

    vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = colors.git.add })
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = colors.git.change })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = colors.git.delete })
    vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = colors.git.change })
    vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = colors.git.ignore })
end

return M
