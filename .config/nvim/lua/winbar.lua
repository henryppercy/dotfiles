local M = {}

function M.setup()
    local icons = require("icons")
    local hls = require("highlights")

    vim.api.nvim_set_hl(0, "WinBarPath", {
        fg = hls.fromhl("Comment").fg,
        bg = hls.fromhl("WinBar").bg,
    })
    vim.api.nvim_set_hl(0, "WinBarFileName", {
        fg = hls.fromhl("WinBar").fg,
        bg = hls.fromhl("WinBar").bg,
        bold = true,
    })

    local function get_winbar()
        local buftype = vim.bo.buftype
        if buftype ~= "" and buftype ~= "nofile" then
            return ""
        end

        local filepath = vim.fn.expand("%:.")
        if filepath == "" then
            return ""
        end

        local filename = vim.fn.expand("%:t")
        local path = filepath:match("(.+)/[^/]+$")

        local result = ""

        if path and path ~= "" then
            path = path:gsub("^/+", "")
            path = path:gsub("/", " " .. icons.arrow.right_tall .. " " .. icons.folder.default .. " ")
            path = icons.folder.default .. " " .. path .. " " .. icons.arrow.right_tall .. " "

            result = "%#WinBarPath#" .. path
        end

        result = result .. "%#WinBarFileName#" .. filename

        if vim.bo.readonly then
            result = result .. " " .. icons.lock
        end

        return " " .. result
    end

    vim.api.nvim_create_autocmd({ "BufEnter", "BufModifiedSet", "WinEnter" }, {
        callback = function()
            local win = vim.api.nvim_get_current_win()
            local config = vim.api.nvim_win_get_config(win)

            if config.relative ~= "" then
                return
            end

            vim.wo.winbar = get_winbar()
        end,
    })
end

return M
