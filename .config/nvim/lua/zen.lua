local M = {}

-- NOTE: vim.g.writing_mode is tracked here so that the winbar autocmd in
-- winbar.lua can skip redraws while zen / writing mode is active.

function M.toggle()
    if vim.g.writing_mode then
        require("lualine").hide({ unhide = true })
        vim.o.laststatus = vim.g._prev_laststatus or 2
        vim.wo.winbar = nil
        vim.cmd("NoNeckPain")
        vim.g.writing_mode = false
    else
        vim.g._prev_laststatus = vim.o.laststatus
        require("lualine").hide()
        vim.o.laststatus = 0
        vim.wo.winbar = ""
        vim.cmd("NoNeckPain")
        vim.g.writing_mode = true
    end
end

return M
