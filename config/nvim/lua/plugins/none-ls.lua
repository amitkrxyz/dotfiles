return {
	-- LSP diagnostics, code actions, and more via Lua.
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.black,
				null_ls.builtins.code_actions.shellcheck
			},
		})
	end,
}
