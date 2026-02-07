local M = {}

function M.register(mappings)
    local present, which_key = pcall(require, "which-key")

    if present then
        which_key.add(mappings)
    end
end

function M.setup()
    local keymap = vim.keymap

    -- Set leader key
    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"

    keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlighting" })

    -- stay in visual mode when indenting
    keymap.set("v", "<", "<gv", { desc = "Indent left" })
    keymap.set("v", ">", ">gv", { desc = "Indent right" })

    -- format
    keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format" })
end

return M
