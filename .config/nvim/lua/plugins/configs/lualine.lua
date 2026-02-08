local M = {
    "nvim-lualine/lualine.nvim",
    lazy = false,
}

function M.opts()
    local icons = require("icons")

    -- Custom filepath component with color change on modified
    local filepath_component = require("lualine.components.filename"):extend()

    function filepath_component:init(options)
        filepath_component.super.init(self, options)

        local hls = require("highlights")

        -- Toggle colour if buffer is modified
        vim.api.nvim_set_hl(0, "LualineFilePathSaved", {
            fg = hls.fromhl("StatusLine").fg,
            bg = hls.fromhl("StatusLine").bg,
        })
        vim.api.nvim_set_hl(0, "LualineFilePathModified", {
            fg = hls.fromhl("DiagnosticWarn").fg,
            bg = hls.fromhl("StatusLine").bg,
        })

        if self.options.color == nil then
            self.options.color = ""
        end
    end

    function filepath_component:update_status()
        local data = filepath_component.super.update_status(self)
        local hl_group = vim.bo.modified and "LualineFilePathModified" or "LualineFilePathSaved"
        return "%#" .. hl_group .. "#" .. data
    end

    -- Macro recording provider
    local function macro_recording()
        local reg = vim.fn.reg_recording()
        if reg ~= "" then
            return icons.camera .. " Recording @" .. reg
        end
        return ""
    end

    local function is_recording()
        return vim.fn.reg_recording() ~= ""
    end

    return {
        options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = {},
                winbar = { "*" },
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = true,
            refresh = {
                statusline = 100,
                tabline = 100,
                winbar = 100,
            },
        },
        sections = {
            lualine_a = {
                {
                    "branch",
                    icon = icons.git.branch,
                },
            },
            lualine_b = {},
            lualine_c = {
                {
                    filepath_component,
                    file_status = true,
                    newfile_status = true,
                    path = 0,
                    symbols = {
                        modified = " [+]",
                        readonly = " " .. icons.lock,
                        unnamed = "[No Name]",
                        newfile = "[New]",
                    },
                },
            },
            lualine_x = {},
            lualine_y = {
                {
                    macro_recording,
                    cond = is_recording,
                    color = "DiagnosticError",
                },
            },
            lualine_z = {
                {
                    "location",
                },
                {
                    "progress",
                },
            },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
    }
end

return M
