-- https://github.com/folke/snacks.nvim
local icons = require("icons")

local M = {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
}

M.opts = {
    dashboard = {
        enabled = true,
        preset = {
            header = table.concat({
                [[                                                                       ]],
                [[                                                                     ]],
                [[       ████ ██████           █████      ██                     ]],
                [[      ███████████             █████                             ]],
                [[      █████████ ███████████████████ ███   ███████████   ]],
                [[     █████████  ███    █████████████ █████ ██████████████   ]],
                [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
                [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
                [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
                [[                                                                       ]],
            }, "\n"),
        },
    },
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
                    layout = {
                        box = "vertical",
                        backdrop = true,
                        row = -2,
                        width = 0,
                        height = 0.9,
                        border = "top",
                        title = " {title} ",
                        title_pos = "center",
                        { win = "input", height = 1, border = "bottom" },
                        {
                            box = "horizontal",
                            { win = "list", border = "none" },
                            {
                                win = "preview",
                                width = 0.4,
                                border = "left",
                            },
                        },
                    },
                }
            else
                return {
                    cycle = true,
                    hidden = { "preview" },
                    layout = {
                        box = "vertical",
                        backdrop = true,
                        row = 1,
                        width = 0.8,
                        height = 0.9,
                        border = "top",
                        title = " {title} ",
                        title_pos = "center",
                        {
                            win = "input",
                            height = 1,
                            border = "bottom",
                        },
                        { win = "list", border = "hpad" },
                    },
                }
            end
        end,
        icons = {
            files = { enabled = false },
        },
        formatters = {
            file = {
                filename_first = true, -- display filename before the file path
                truncate = 40, -- truncate the file path to (roughly) this length
            },
        },
        win = { -- Global
            preview = {
                wo = {
                    foldcolumn = "0",
                    number = false,
                    relativenumber = false,
                    signcolumn = "no",
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
}

M.keys = {
    { "<leader><space>", function() require("snacks").picker.smart() end,                  desc = "Smart Find Files" },
    { "<leader>ff",      function() require("snacks").picker.files({ hidden = true }) end, desc = "Find Files" },
    { "<leader>fg",      function() require("snacks").picker.grep() end,                   desc = "Grep" },
    { "<leader>fb",      function() require("snacks").picker.buffers() end,                desc = "Buffers" },
    { "<leader>fh",      function() require("snacks").picker.help() end,                   desc = "Help" },
    { "<leader>fr",      function() require("snacks").picker.recent() end,                 desc = "Recent Files" },

    { "gd",              function() require("snacks").picker.lsp_definitions() end,                   desc = "Go to definition" },
    { "gD",              function() require("snacks").picker.lsp_declarations() end,                  desc = "Go to declaration" },
    { "gi",              function() require("snacks").picker.lsp_implementations() end,               desc = "Go to implementation" },
    { "gr",              function() require("snacks").picker.lsp_references() end,                    desc = "Go to references" },
    { "gy",              function() require("snacks").picker.lsp_type_definitions() end,              desc = "Go to type definition" },

    { "<leader>gg",      function() require("snacks").lazygit() end,                       desc = "Lazygit" },
    { "<leader>gb",      function() require("snacks").picker.git_branches() end,           desc = "Git Branches" },
    { "<leader>gl",      function() require("snacks").picker.git_log() end,                desc = "Git Log" },
    { "<leader>gf",      function() require("snacks").picker.git_log_file() end,           desc = "Git Log File" },
    { "<leader>gs",      function() require("snacks").picker.git_status() end,             desc = "Git Status" },
    { "<leader>gS",      function() require("snacks").picker.git_stash() end,              desc = "Git Stash" },
    { "<leader>gd",      function() require("snacks").picker.git_diff() end,               desc = "Git Diff (Hunks)" },
}

return M
