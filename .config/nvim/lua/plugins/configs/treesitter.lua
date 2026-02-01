local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
}

function M.config()
	local treesitter = require("nvim-treesitter")
	
	treesitter.setup({
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"javascript",
			"typescript",
            "go",
            "php",
			"html",
			"css",
			"json",
			"markdown",
			"bash",
		},

		auto_install = true, -- Auto-install missing parsers when entering buffer

		highlight = { enable = true },
		indent = { enable = true },
	})
end

return M
