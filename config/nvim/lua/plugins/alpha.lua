return {
	-- a lua powered greeter like vim-startify / dashboard-nvim
	'goolord/alpha-nvim',
	dependencies = {
		'nvim-tree/nvim-web-devicons',
		'nvim-lua/plenary.nvim'
	},
	config = function()
		require 'alpha'.setup(require 'alpha.themes.theta'.config)
	end
};
