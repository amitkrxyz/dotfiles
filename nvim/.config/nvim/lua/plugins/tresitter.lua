return {
	{
		-- Nvim Treesitter configurations and abstraction layer
		"nvim-treesitter/nvim-treesitter",
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
