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
    },
    picker = {
        enabled = true,
    },
    
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
    { "<leader>ff", function() require("snacks").picker.files({ hidden = true }) end, desc = "Find Files" },
    { "<leader>fg", function() require("snacks").picker.grep() end, desc = "Grep" },
    { "<leader>fb", function() require("snacks").picker.buffers() end, desc = "Buffers" },
    { "<leader>fh", function() require("snacks").picker.help() end, desc = "Help" },
    { "<leader>fr", function() require("snacks").picker.recent() end, desc = "Recent Files" },
}

return M

