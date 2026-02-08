local M = {}

-- Extract fg/bg colors from an existing highlight group
function M.fromhl(hl)
    local result = {}
    local list = vim.api.nvim_get_hl(0, { name = hl, link = false })
    for k, v in pairs(list) do
        if k == "fg" or k == "bg" then
            result[k] = string.format("#%06x", v)
        end
    end
    return result
end

-- Get commonly-used colors from current colorscheme
function M.colors()
    return {
        fg = M.fromhl("Normal").fg,
        bg = M.fromhl("Normal").bg,
        statusline_fg = M.fromhl("StatusLine").fg,
        statusline_bg = M.fromhl("StatusLine").bg,
        warn_fg = M.fromhl("DiagnosticWarn").fg,
        error_fg = M.fromhl("DiagnosticError").fg,
        info_fg = M.fromhl("DiagnosticInfo").fg,
        hint_fg = M.fromhl("DiagnosticHint").fg,
    }
end

-- Register custom highlight groups
function M.register_hls(groups)
    for name, attrs in pairs(groups) do
        if type(attrs) == "string" then
            vim.api.nvim_set_hl(0, name, { link = attrs })
        else
            vim.api.nvim_set_hl(0, name, attrs)
        end
    end
end

return M
