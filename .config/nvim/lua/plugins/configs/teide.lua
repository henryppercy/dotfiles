-- https://github.com/serhez/teide.nvim
local M = {
	"serhez/teide.nvim",
	name = "teide.nvim",
}

function M.config()
	local teide = require("teide")
	teide.setup({
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
		plugins = {
			auto = true,
		},
		dim_inactive = false,
	})
	teide.load()
end

return M

