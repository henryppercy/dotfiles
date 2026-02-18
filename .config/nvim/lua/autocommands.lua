local M = {}

function M.setup()
    vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
            vim.highlight.on_yank()
        end,
    })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "help",
        callback = function()
            vim.cmd("wincmd L")
        end,
    })

    vim.api.nvim_create_autocmd("BufRead", {
        pattern = "/tmp/zsh*",
        callback = function()
            vim.bo.filetype = "bash"
        end,
    })

    vim.api.nvim_create_user_command('DiffClipboard', function()
        vim.cmd('vnew | put + | diffthis | wincmd p | diffthis')
    end, {})
end

return M
