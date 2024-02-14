return {
	-- The undo history visualizer for
	{ 'mbbill/undotree' },
	{
		-- Library of 35+ independent Lua modules improving overall Neovim
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.surround").setup()
			require("mini.comment").setup()
			require("mini.ai").setup()
		end,
	},
	{
		-- Indent guides for Neovim
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup()
		end,
	},
	{
		-- Statusline plugin written in pure lua.
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({})
		end,
	},
	{
		-- autopairs for neovim written by lua
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {} -- this is equalent to setup({}) function
	},
	{
		-- A lua plugin to manage multiple terminal windows
		'akinsho/toggleterm.nvim',
		version = "*",
		config = function()
			require("toggleterm").setup {
				open_mapping = [[<c-\>]],
				direction = 'float'
			}
		end
	},
}
