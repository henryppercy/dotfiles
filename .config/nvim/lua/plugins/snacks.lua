local M = {}

function M.setup()
    local icons = require("icons")

    local git_picker_layout = {
        layout = {
            preset = "default",
            layout = { backdrop = true, width = 0.9, height = 0.9 },
        },
    }

    require("snacks").setup({
        dashboard = { enabled = false },
        indent = {
            enabled = true,
            chunk = {
                enabled = true,
                char = { arrow = icons.bar.horizontal_thin },
            },
            animate = { enabled = false, },
        },
        picker = {
            layout = function()
                if vim.o.columns >= 120 then
                    return {
                        cycle = true,
                        preset = "vertical",
                        layout = { backdrop = true, width = 0.8, height = 0.8 },
                    }
                end
                return {
                    layout = { backdrop = true, },
                    cycle = true,
                    preset = "select"
                }
            end,
            sources = {
                git_branches = git_picker_layout,
                git_log = git_picker_layout,
                git_log_file = git_picker_layout,
                git_status = git_picker_layout,
                git_stash = git_picker_layout,
                git_diff = git_picker_layout,
                buffers = {
                    layout = {
                        preset = "dropdown",
                        layout = { backdrop = true, height = 0.6, row = 0.2 },
                        preview = false,
                    },
                },
            },
            icons = {
                files = { enabled = false },
            },
            formatters = {
                file = {
                    filename_first = true,
                    truncate = 40,
                },
            },
            win = {
                preview = {
                    wo = {
                        foldcolumn = "0",
                        number = false,
                        relativenumber = false,
                        signcolumn = "no",
                        winbar = "",
                    },
                },
            },
        },
        lazygit = {},

        bigfile = { enabled = false },
        explorer = { enabled = false },
        input = { enabled = false },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
    })

    local snacks = require("snacks")
    local map = vim.keymap.set

    map("n", "<leader><space>", function() snacks.picker.smart() end, { desc = "Smart Find Files" })
    map("n", "<leader>ff", function() snacks.picker.files({ hidden = true }) end, { desc = "Find Files" })
    map("n", "<leader>fg", function() snacks.picker.grep() end, { desc = "Grep" })
    map("n", "<leader>fb", function() snacks.picker.buffers() end, { desc = "Buffers" })
    map("n", "<leader>fh", function() snacks.picker.help() end, { desc = "Help" })
    map("n", "<leader>fr", function() snacks.picker.recent() end, { desc = "Recents" })

    map("n", "<leader>fa", function() snacks.picker.files({ hidden = true, ignored = true }) end, { desc = "Find All Files (incl. gitignored)" })
    map("n", "<leader>fG", function() snacks.picker.grep({ ignored = true, hidden = true }) end, { desc = "Grep All (incl. gitignored)" })
    map("n", "<leader>fe", function() snacks.picker.files({ ignored = true, hidden = true, args = { "--glob", ".env*" } }) end, { desc = "Find Env Files" })

    map("n", "<leader>fc", function() snacks.picker.todo_comments() end, { desc = "Comments" })
    map("n", "<leader>ft", function() snacks.picker.todo_comments({ keywords = { "TODO" } }) end, { desc = "TODOs" })
    map("n", "<leader>fn", function() snacks.picker.todo_comments({ keywords = { "NOTE" } }) end, { desc = "Notes" })
    map("n", "<leader>fp", function() snacks.picker.todo_comments({ keywords = { "PR" } }) end, { desc = "PRs" })

    map("n", "gd", function() snacks.picker.lsp_definitions() end, { desc = "Go to definition" })
    map("n", "gD", function() snacks.picker.lsp_declarations() end, { desc = "Go to declaration" })
    map("n", "gi", function() snacks.picker.lsp_implementations() end, { desc = "Go to implementation" })
    map("n", "gr", function() snacks.picker.lsp_references() end, { desc = "Go to references" })
    map("n", "gy", function() snacks.picker.lsp_type_definitions() end, { desc = "Go to type definition" })

    map("n", "<leader>gg", function() snacks.lazygit() end, { desc = "Lazygit" })
    map("n", "<leader>gb", function() snacks.picker.git_branches() end, { desc = "Git Branches" })
    map("n", "<leader>gl", function() snacks.picker.git_log() end, { desc = "Git Log" })
    map("n", "<leader>gf", function() snacks.picker.git_log_file() end, { desc = "Git Log File" })
    map("n", "<leader>gs", function() snacks.picker.git_status() end, { desc = "Git Status" })
    map("n", "<leader>gS", function() snacks.picker.git_stash() end, { desc = "Git Stash" })
    map("n", "<leader>gd", function() snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
end

return M
