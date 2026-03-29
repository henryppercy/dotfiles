local M = {
    "serhez/bento.nvim",
    enabled = false,
}

function M.config()
    require("bento").setup({
        max_open_buffers = 5,
        buffer_deletion_metric = "frecency_access",
        ui = {
            floating = {
                max_rendered_buffers = 5,
            },
        },
        actions = {
            copy_path = {
                key = "y",
                action = function(_, _)
                    local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
                    vim.fn.setreg("+", path)
                    vim.notify(path, vim.log.levels.INFO, { title = "Copied path" })
                end,
            },
        },
    })
end

return M
