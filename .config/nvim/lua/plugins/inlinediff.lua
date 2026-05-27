local M = {}

function M.setup()
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
