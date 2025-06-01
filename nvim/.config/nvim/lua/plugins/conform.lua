return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "n",
			desc = "Format buffer",
		},
	},

	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			python = {  "black" },
			-- Use a sub-list to run only the first available formatter
			javascript = { "prettierd", "prettier" },
			typescript = { "prettierd", "prettier" },
			typescriptreact = { "prettierd", "prettier" },
			javascriptreact = { "prettierd", "prettier" },
			astro = { "prettierd", "prettier", stop_after_first = true },
		},
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
	},
}
