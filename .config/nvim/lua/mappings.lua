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
    keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })

    keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlighting" })

    -- stay in visual mode when indenting
    keymap.set("v", "<", "<gv", { desc = "Indent left" })
    keymap.set("v", ">", ">gv", { desc = "Indent right" })

    -- code
    keymap.set("n", "<leader>cf", function() require("conform").format({ lsp_format = "fallback" }) end,
        { desc = "Format" })
    keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
    keymap.set("n", "<leader>ce", vim.diagnostic.open_float, { desc = "Diagnostic float" })
    keymap.set("n", "<leader>cy", function()
        local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
        if vim.tbl_isempty(diagnostics) then
            vim.notify("No diagnostics on this line", vim.log.levels.WARN)
            return
        end
        local messages = vim.tbl_map(function(d) return d.message end, diagnostics)
        local text = table.concat(messages, "\n")
        vim.fn.setreg("+", text)
        vim.notify(text, vim.log.levels.INFO, { title = "Copied diagnostic" })
    end, { desc = "Yank diagnostic" })
    keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })

    -- buffer
    keymap.set("n", "<leader>bb", "<C-^><CR>", { desc = "Alternative buffer" })
    keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
    keymap.set("n", "<leader>by", function()
        local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
        vim.fn.setreg("+", path)
        vim.notify(path, vim.log.levels.INFO, { title = "Copied path" })
    end, { desc = "Copy relative path" })
    keymap.set("n", "<leader>bY", ":%y+<CR>", { desc = "Yank buffer to clipboard" })
    keymap.set("n", "<leader>bc", "<cmd>NoNeckPain<CR>", { desc = "Center buffer" })

    -- split navigation
    keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
    keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
    keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
    keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

    -- insert
    keymap.set(
        "n",
        "<leader>it",
        function() vim.api.nvim_put({ tostring(os.date("%H:%M")) }, "l", true, true) end,
        { desc = "Insert timestamp" }
    )
    keymap.set(
        "n",
        "<leader>id",
        function() vim.api.nvim_put({ tostring(os.date("%Y-%m-%d")) }, "l", true, true) end,
        { desc = "Insert date" }
    )
    keymap.set(
        "n",
        "<leader>idt",
        function() vim.api.nvim_put({ tostring(os.date("%a %Y-%m-%d - %H:%M")) }, "l", true, true) end,
        { desc = "Insert date and timestamp" }
    )
    keymap.set(
        "n",
        "<leader>ix",
        "o- [ ] ",
        { desc = "Insert checkbox" }
    )

    -- checkbox state (operates on the current line regardless of cursor column)
    local function set_checkbox(state)
        return function()
            local line = vim.fn.getline(".")
            vim.fn.setline(".", (line:gsub("%[.%]", "[" .. state .. "]", 1)))
        end
    end

    keymap.set("n", "<leader>xx", set_checkbox("x"), { desc = "Checkbox done" })
    keymap.set("n", "<leader>x-", set_checkbox("-"), { desc = "Checkbox in progress" })
    keymap.set("n", "<leader>x/", set_checkbox("/"), { desc = "Checkbox pending" })
    keymap.set("n", "<leader>x<Space>", set_checkbox(" "), { desc = "Checkbox clear" })
end

return M
