return {
	"habamax/vim-godot",
	-- -- sleuth.vim: Heuristically set buffer options
	-- -- "tpope/vim-sleuth",
	-- -- folke/trouble.nvim
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	-- Markdown viewer
	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup({
				syntax = true,
				app = "browser",
			})
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
	-- tadmccorkle/markdown.nvim
	{
		"tadmccorkle/markdown.nvim",
		ft = "markdown", -- or 'event = "VeryLazy"'
		opts = {
			-- configuration here or empty for defaults
		},
	},
	-- Supermaven
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({})
		end,
	},
	-- The undo history visualizer for
	{ "mbbill/undotree" },
	{
		-- Library of 35+ independent Lua modules improving overall Neovim
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.surround").setup()
			require("mini.comment").setup()
			-- require("mini.ai").setup()
		end,
	},
	-- {
	-- 	-- Indent guides for Neovim
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	main = "ibl",
	-- 	opts = {
	-- 		scope = {
	-- 			show_start = false,
	-- 		},
	-- 	},
	-- 	-- config = function()
	-- 	-- 	require("ibl").setup()
	-- 	-- end,
	-- },
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
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		-- A lua plugin to manage multiple terminal windows
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-\>]],
				direction = "float",
			})
		end,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({})
		end,
	},
	-- {
	-- 	"akinsho/flutter-tools.nvim",
	-- 	lazy = false,
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"stevearc/dressing.nvim", -- optional for vim.ui.select
	-- 	},
	-- 	config = true,
	-- },
}
