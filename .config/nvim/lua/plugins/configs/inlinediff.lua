local M = {
    "YouSame2/inlinediff-nvim",
    lazy = true,
    cmd = "InlineDiff",
}

function M.init()
    require("mappings").register({ "<leader>gD", function() require("inlinediff").toggle() end, desc = "Toggle Inline Diff" })
end

function M.config()
    local colors = require("teide.colors").setup()

    require("inlinediff").setup({
        colors = {
            InlineDiffAddContext = colors.diff.add,
            InlineDiffAddChange = colors.diff.text,
            InlineDiffDeleteContext = colors.diff.delete,
            InlineDiffDeleteChange = colors.diff.delete,
        },
    })
end

return M
