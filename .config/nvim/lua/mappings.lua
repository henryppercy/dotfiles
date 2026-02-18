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

    -- code
    keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format" })
    keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
    keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })

    -- buffer
    keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

    -- split navigation
    keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
    keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
    keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
    keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
end

return M
