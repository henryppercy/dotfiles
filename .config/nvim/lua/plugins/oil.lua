local M = {}

function M.setup()
    local icons = require("icons")

    require("mappings").register({
        "<leader>e",
        function()
            vim.cmd("Oil")
        end,
        desc = "Explorer",
    })

    require("oil").setup({
        default_file_explorer = true,
        delete_to_trash = true,
        columns = {
            {
                "icon",
                default_file = icons.file.filled,
                directory = icons.folder.default,
                add_padding = false,
            },
        },
        preview_win = {
            preview_method = "fast_scratch",
            win_options = {},
            buf_options = {
                modifiable = false,
            },
        },
        cleanup_delay_ms = 0,
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name)
                return name == ".."
            end,
        },
    })
end

return M
