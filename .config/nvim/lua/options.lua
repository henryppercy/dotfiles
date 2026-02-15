local M = {}

function M.setup()
	local opt = vim.opt
	local cmd = vim.cmd
	local CACHE_PATH = vim.fn.stdpath("cache")

	cmd("set inccommand=split") -- show what you are substituting in real time
	cmd("set iskeyword+=-") -- treat dash as a separate word
	cmd("autocmd VimResized * wincmd =") -- keep splits balanced

	opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
	opt.backup = false -- creates a backup file
	opt.swapfile = false -- creates a swapfile
	opt.undodir = CACHE_PATH .. "/undo" -- set an undo directory
	opt.undofile = true -- enable persisten undo
	opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
	opt.smartcase = true -- smart case
	opt.smartindent = true -- makes indenting smarter
	opt.autoindent = true -- makes indenting automatic
	opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
	opt.keywordprg = ":help" -- use help instead of man
	opt.splitbelow = true -- force all horizontal splits to go below current window
	opt.splitright = true -- force all vertical splits to go to the right of current window
	opt.termguicolors = true -- set term gui colors (most terminals support this)
	opt.expandtab = true -- convert tabs to spaces
	opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
	opt.tabstop = 4 -- insert 4 spaces for a tab
	opt.cursorline = true -- highlight the current line
	opt.number = true -- set numbered lines
	opt.laststatus = 3 -- display one statusline for all windows

    -- make TreeSitter highlight groups have higher priority than LSP semantic tokens
	vim.highlight.priorities.treesitter = 100
	vim.highlight.priorities.semantic_tokens = 95
end

return M
