local M = {}

function M.setup()
    local icons = require("icons")

    require("mappings").register({
        { "<leader>b",  group = "Buffer" },
        { "<leader>c",  group = "Code" },
        { "<leader>f",  group = "Find" },
        { "<leader>g",  group = "Git" },
        { "<leader>I",  group = "Install" },
        { "<leader>i",  group = "Insert" },
        { "<leader>n",  group = "Notes" },
        { "<leader>nt", group = "Time" },
        { "<leader>z",  group = "Zen" },
    })

    require("which-key").setup({
        preset = "helix",
        icons = {
            breadcrumb = icons.arrow.double_right_short,
            separator = icons.bar.vertical_center_thin,
            group = icons.folder.open .. " ",
        },
        win = {
            border = "none",
            title = true,
            title_pos = "center",
            padding = { 2, 6 },
        },
        show_help = false,
        show_keys = true,
    })
end

return M
