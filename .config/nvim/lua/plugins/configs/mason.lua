local M = {
	"williamboman/mason.nvim",
}

function M.init()
	require("mappings").register({ "<leader>is", "<cmd>Mason<cr>", desc = "Servers panel" })
end

function M.config()
	require("mason").setup({
		ui = {
			border = "none", -- the border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		},
	})
end

return M
