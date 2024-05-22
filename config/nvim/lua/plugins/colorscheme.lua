-- folke/tokyonight.nvim
return {
	{
		"folke/tokyonight.nvim",
		opts = {},
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				transparent = true,
			})
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"iruzo/matrix-nvim",
		config = function()
			-- Example config in lua
			vim.g.matrix_contrast = true
			vim.g.matrix_borders = false
			vim.g.matrix_disable_background = true
			vim.g.matrix_italic = false
			-- Load the colorscheme
			-- require("matrix").set()
		end,
	},
}
