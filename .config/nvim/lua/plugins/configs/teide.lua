-- https://github.com/serhez/teide.nvim
local M = {
    "serhez/teide.nvim",
    name = "teide.nvim",
}

function M.config()
    local teide = require("teide")
    teide.setup({
        terminal_colors = true,
        style = "darker",
        styles = {
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},

            -- Background styles: "dark", "transparent", "normal"
            sidebars = "dark",
            floats = "dark",
        },
        plugins = {
            auto = true,
        },
        dim_inactive = false,
    })
    teide.load()

    -- can this be done in the snacks.picker config
    local colors = require("teide.colors").setup()
    vim.api.nvim_set_hl(0, "SnacksPicker", { bg = colors.bg_darker, nocombine = true })
    vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = colors.fg_gutter, bg = colors.bg_darker, nocombine = true })
    vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = colors.fg_gutter, bg = colors.bg_darker, nocombine = true })
end

return M
