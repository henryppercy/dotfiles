local M = {}

function M.setup()
    local keymap = vim.keymap

    -- Set leader key
    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"

    keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlighting" })

    -- stay in visual mode when indenting
    keymap.set("v", "<", "<gv", { desc = "Indent left" })
    keymap.set("v", ">", ">gv", { desc = "Indent right" })
end

return M
