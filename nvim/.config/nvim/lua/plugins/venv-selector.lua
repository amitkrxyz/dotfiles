return {
	'linux-cultist/venv-selector.nvim',
	dependencies = {
		"neovim/nvim-lspconfig",
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
	},
	opts = {
		-- Your options go here
		-- name = "venv",
		-- auto_refresh = false
	},
	ft = "python",
	event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
	keys = {
		-- Keymap to open VenvSelector to pick a venv.
		{ '<leader>vs', '<cmd>VenvSelect<cr>' },
		-- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
		{ '<leader>vc', '<cmd>VenvSelectCached<cr>' },
	},
}
