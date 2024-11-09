return {
	{
		-- Nvim Treesitter configurations and abstraction layer
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				auto_install = false,
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		-- Show code context
		"nvim-treesitter/nvim-treesitter-context",
	},
}
