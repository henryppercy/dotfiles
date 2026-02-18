local M = {
    "serhez/bento.nvim"
}

function M.config()
    require("bento").setup({
        max_open_buffers = 5,
        buffer_deletion_metric = "frecency_access",
        ui = {
            floating = {
                max_rendered_buffers = 5,
            },
        }
    })
end

return M
