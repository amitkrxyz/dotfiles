---@diagnostic disable: missing-fields
return {
	{
		-- Nvim Treesitter configurations and abstraction layer
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		auto_install = true,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
				},
				indent = {
					enable = true
				},
				incremental_selection = {
					enable = true
				}
			})
		end,
	},
	{
		-- Show code context
		"nvim-treesitter/nvim-treesitter-context",
	},
}
