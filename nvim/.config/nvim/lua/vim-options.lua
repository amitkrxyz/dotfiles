vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8

vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.wrap = false

vim.opt.undofile = true
vim.opt.swapfile = false

-- vim.g.netrw_banner = 0
vim.g.undotree_SetFocusWhenToggle = true

-- tresitter folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldlevel = 99

-- Causes issues
-- with Telscope not searching in entire project
-- Fixes move in netrw
-- vim.g.netrw_keepdir = 0

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", eol = "↲" }

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
