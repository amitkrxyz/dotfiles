return {
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
			"mfussenegger/nvim-dap-python", --optional
			{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
		},
		branch = "regexp",
		lazy = false,
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "python",
				callback = function()
					require("venv-selector").setup()
					require("lualine").setup({
						sections = { lualine_y = { "venv-selector" } },
					})
					vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>")
					vim.keymap.set("n", "<leader>vc", "<cmd>VenvSelectCached<cr>")
					vim.keymap.set("n", "<leader>vp", '<cmd>:lua print(require("venv-selector").get_active_path())<cr>')
					-- local venv = vim.fn.findfile("Pipfile", vim.fn.getcwd() .. ";")
					-- if venv ~= "" then
					-- 	require("venv-selector").retrieve_from_cache()
					-- 	vim.cmd("LspRestart")
					-- end
				end,
			})
		end,
		-- opts = {
		-- Your options go here
		-- name = "venv",
		-- auto_refresh = false
		-- },
		-- event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
		-- keys = {
		-- 	-- Keymap to open VenvSelector to pick a venv.
		-- 	{ "<leader>vs", "<cmd>VenvSelect<cr>" },
		-- 	-- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
		-- 	{ "<leader>vc", "<cmd>VenvSelectCached<cr>" },
		-- 	-- Print current virtual environment
		-- 	{ "<leader>vp", '<cmd>:lua print(require("venv-selector").get_active_path())<cr>' },
		-- },
	},
}
