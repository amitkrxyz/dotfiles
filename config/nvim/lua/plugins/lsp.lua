return {
	'neovim/nvim-lspconfig',
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		'windwp/nvim-autopairs',
		"nvimtools/none-ls.nvim",
	},
	config = function()
		local ensure_installed = { "lua_ls", "tsserver", "pyright" }
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

		local lspconfig = require("lspconfig")
		local handlers = {
			-- The first entry (without a key) will be the default handler
			-- and will be called for each installed server that doesn't have
			-- a dedicated handler.
			function(server_name) -- default handler (optional)
				require("lspconfig")[server_name].setup { capabilities = capabilities }
			end,

			["lua_ls"] = function()
				lspconfig.lua_ls.setup { settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" }
						}
					}
				}
				}
			end,
			["tsserver"] = function()
				lspconfig.tsserver.setup {
					root_dir = lspconfig.util.root_pattern("package.json")
				}
			end,
			["denols"] = function()
				lspconfig.denols.setup {
					root_dir = lspconfig.util.root_pattern("deno.json")
				}
			end,
		}
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = ensure_installed,
			handlers = handlers
		})
		require("fidget").setup()
		local luasnip = require("luasnip")
		local cmp = require("cmp")
		require("luasnip.loaders.from_vscode").lazy_load()
		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			window = {
				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.


				-- Luasnip mapping
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- that way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lua' },
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' }, -- For luasnip users.
			}, {
				{ name = 'buffer' },
			})
		})

		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- Add sources here as needed
				null_ls.builtins.formatting.black,
				-- null_ls.builtins.formatting.prettier,
			},
		})

		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
		cmp.event:on(
			'confirm_done',
			cmp_autopairs.on_confirm_done()
		)
	end
}
