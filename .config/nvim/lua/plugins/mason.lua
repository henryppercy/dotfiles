local M = {}

function M.setup()
    require("mappings").register({ "<leader>Is", "<cmd>Mason<cr>", desc = "Servers panel" })

    require("mason").setup({
        ui = {
            border = "none",
        },
    })
end

return M
