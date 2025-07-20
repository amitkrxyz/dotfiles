return {
	{
		-- Nvim Treesitter configurations and abstraction layer
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		auto_install = true,
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({})
		end,
	},
	{
		-- Show code context
		"nvim-treesitter/nvim-treesitter-context",
	},
}
