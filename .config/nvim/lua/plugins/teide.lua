local M = {}

function M.setup()
    local teide = require("teide")
    teide.setup({
        cache = false,
        plugins = { all = true },
        terminal_colors = true,
        style = "darker",
        styles = {
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},

            -- Background styles: "dark", "transparent", "normal"
            sidebars = "dark",
            floats = "dark",
        },
        dim_inactive = false,
        on_highlights = function(hl, c)
            for i = 1, 6 do
                hl["@markup.heading." .. i .. ".markdown"] = { fg = c.fg, bold = true }
                hl["RenderMarkdownH" .. i .. "Bg"] = { bg = c.bg_dark }
            end
            hl["@markup.heading.1.markdown"] = { fg = c.fg, bold = true }
            hl["@markup.heading.2.markdown"] = { fg = c.fg, bold = true }
            hl["@markup.heading.3.markdown"] = { fg = c.fg, }
            hl["@markup.heading.4.markdown"] = { fg = c.fg, }
            hl["@markup.heading.5.markdown"] = { fg = c.fg, italic = true }
            hl["@markup.heading.6.markdown"] = { fg = c.fg, italic = true }

            hl["RenderMarkdownBullet"] = { fg = c.fg }
            hl["RenderMarkdownDash"] = { fg = c.fg }
            hl["RenderMarkdownTableHead"] = { fg = c.fg }
            hl["RenderMarkdownTableRow"] = { fg = c.fg }
            hl["RenderMarkdownChecked"] = { fg = c.fg }
            hl["RenderMarkdownUnchecked"] = { fg = c.fg }
            hl["RenderMarkdownTodo"] = { fg = c.fg }
            hl["@markup.list.checked"] = { fg = c.fg }
            hl["@markup.list.unchecked"] = { fg = c.fg }
            -- yaml frontmatter
            hl["@tag.yaml"] = { fg = c.fg }                   -- keys
            hl["@string.yaml"] = { fg = c.fg }                -- string values
            hl["@number.yaml"] = { fg = c.fg }                -- number values
            hl["@punctuation.delimiter.yaml"] = { fg = c.fg } -- colons
            hl["@punctuation.separator.yaml"] = { fg = c.fg } -- dashes in lists

            -- frontmatter delimiters (the --- lines)
            hl["@punctuation.delimiter.markdown"] = { fg = c.fg }

            -- links
            hl["@markup.link.label.markdown_inline"] = { fg = c.fg, underline = true }
            hl["@markup.link.url.markdown_inline"] = { fg = c.fg }
            hl["@markup.link.markdown_inline"] = { fg = c.fg }
            hl["RenderMarkdownLink"] = { fg = c.fg }

            -- other bits you might still see coloured
            hl["@markup.italic.markdown_inline"] = { fg = c.fg, italic = true }
            hl["@markup.strong.markdown_inline"] = { fg = c.fg, bold = true }
            hl["@markup.strikethrough.markdown_inline"] = { fg = c.fg, strikethrough = true }
            hl["@markup.raw.markdown_inline"] = { fg = c.fg } -- inline code text

            hl["RenderMarkdownCode"] = { bg = c.bg_dark }
            hl["RenderMarkdownCodeInline"] = { bg = c.bg_dark }
            hl["RenderMarkdownCodeBorder"] = { bg = c.bg_dark }
            hl["@markup.list.markdown"] = { fg = c.fg, bold = true }

            hl["RenderMarkdownCancelled"] = { fg = c.fg_dark }
            hl["RenderMarkdownCancelledScope"] = { fg = c.fg_dark, strikethrough = true }
        end,
    })
    teide.load()

    local colors = require("teide.colors").setup()
    vim.api.nvim_set_hl(0, "SnacksPicker", { bg = colors.bg_darker, nocombine = true })
    vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = colors.fg_gutter, bg = colors.bg_darker, nocombine = true })
    vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { fg = colors.fg_gutter, bg = colors.bg_darker, nocombine = true })
end

return M
