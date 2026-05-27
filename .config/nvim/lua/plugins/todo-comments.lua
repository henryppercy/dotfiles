local M = {}

function M.setup()
    local icons = require("icons")

    require("todo-comments").setup({
        signs = false,
        sign_priority = 90,
        keywords = {
            FIX = {
                icon = icons.diagnostics.bug .. " ",
                color = "error",
            },
            TODO = { icon = icons.check .. " ", color = "info" },
            HACK = { icon = icons.fire .. " ", color = "warning" },
            WARN = {
                icon = icons.diagnostics.warning .. " ",
                color = "warning",
                alt = { "WARNING", "XXX" },
            },
            NOTE = { icon = icons.message .. " ", color = "hint", alt = { "INFO" } },
            PR = { icon = icons.message .. " ", color = "hint", alt = { "INFO" } },
        },
    })
end

return M
