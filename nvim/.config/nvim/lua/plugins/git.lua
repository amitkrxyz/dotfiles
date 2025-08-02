return {
	{
		-- fugitive.vim: A Git wrapper so awesome, it should be illegal
		"tpope/vim-fugitive",
		config = function()
			vim.g.fugitive_git_dir = vim.fn.expand("~/.git")
		end,
	},
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			local gitsigns = require('gitsigns')
			gitsigns.setup {
				numhl = true,
				sign_priority = 6, -- higher than diagnostic,todo signs. lower than dapui breakpoint sign
				on_attach = function()
					vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk_inline)
					vim.keymap.set('n', ']c', function()
						if vim.wo.diff then
							vim.cmd.normal({ ']c', bang = true })
						else
							gitsigns.nav_hunk('next')
						end
					end)
					vim.keymap.set('n', '[c', function()
						if vim.wo.diff then
							vim.cmd.normal({ '[c', bang = true })
						else
							gitsigns.nav_hunk('prev')
						end
					end)
					vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk)
					vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer)
				end

			}
		end
	}
}
