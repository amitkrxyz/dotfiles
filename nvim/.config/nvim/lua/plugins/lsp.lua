return {
	"neovim/nvim-lspconfig",
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
		"windwp/nvim-autopairs",
		"nvimtools/none-ls.nvim",
		"onsails/lspkind.nvim",
	},
	config = function()
		local ensure_installed = { "lua_ls" }
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		local lspconfig = require("lspconfig")
		local handlers = {
			-- The first entry (without a key) will be the default handler
			-- and will be called for each installed server that doesn't have
			-- a dedicated handler.
			function(server_name) -- default handler (optional)
				require("lspconfig")[server_name].setup({ capabilities = capabilities })
			end,

			["lua_ls"] = function()
				lspconfig.gdscript.setup({
					name = "godot",
					cmd = vim.lsp.rpc.connect("127.0.0.1", "6005"),
				})
				lspconfig.lua_ls.setup({
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				})
			end,
			["basedpyright"] = function()
				lspconfig.basedpyright.setup({
					capabilities = capabilities,
					settings = {
						basedpyright = {
							typeCheckingMode = "standard",
						},
					},
				})
			end,
			["ts_ls"] = function()
				lspconfig.ts_ls.setup({
					root_dir = lspconfig.util.root_pattern("package.json"),
					single_file_support = false,
				})
			end,
			["denols"] = function()
				lspconfig.denols.setup({
					root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
				})
			end,
		}
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = ensure_installed,
			handlers = handlers,
		})
		require("fidget").setup()
		-- local luasnip = require("luasnip")
		local cmp = require("cmp")
		require("luasnip").filetype_extend("javascript", { "jsdoc" })
		require("luasnip.loaders.from_vscode").lazy_load()
		cmp.setup({
			experimental = {
				ghost_text = true,
			},
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			window = {
				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lua" },
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "path" },
				{ name = "buffer" },
			}),
			formatting = {
				format = require("lspkind").cmp_format({
					-- mode = "symbol",
					maxwidth = function()
						return math.floor(0.25 * vim.o.columns)
					end,
					ellipsis_char = "...",
					menu = {
						buffer = "[buf]",
						nvim_lsp = "[LSP]",
						nvim_lua = "[api]",
						path = "[path]",
						luasnip = "[snip]",
					},
				}),
			},
		})

		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
