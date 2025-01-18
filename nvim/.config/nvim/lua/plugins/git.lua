return {
	{
		-- fugitive.vim: A Git wrapper so awesome, it should be illegal
		"tpope/vim-fugitive",
		config = function()
			vim.g.fugitive_git_dir = vim.fn.expand("~/.git")
		end,
	},
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			numhl = true,
			sign_priority = 15, -- higher than diagnostic,todo signs. lower than dapui breakpoint sign
		},
	}
}
