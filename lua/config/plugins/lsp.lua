return {
	{
		"ziglang/zig.vim",
	},
	{
		'saghen/blink.cmp',
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		}
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config('clangd', {
				cmd = { "clangd", "--fallback-style=webkit" },
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
			})
			vim.lsp.enable('clangd')
			vim.lsp.enable('zls')
			vim.lsp.enable('lua_ls');

			vim.lsp.config('jails', {
				cmd = { "jails" },
				filetypes = { "jai" },
				root_file_markers = { "build.jai", "main.jai" }
			})
			vim.lsp.enable('jails')

			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then return end

					--if client.supports_method('textDocument/implementation') then
					--	-- Create a keymap for vim.lsp.buf.implementation
					--
					-- map("gi", require('telescope.builtin').lsp_implementations)?
					--end
					--
					--if client.supports_method('textDocument/completion') then
					--	vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
					--end

					if client.supports_method('textDocument/formatting') then
						vim.api.nvim_create_autocmd('BufWritePre', {
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
							end,
						})
					end
				end
			})
		end
	}
	--return {
	--	{
	--		"neovim/nvim-lspconfig",
	--		dependencies = {
	--			'saghen/blink.cmp',
	--			{
	--			},
	--		},
	--		config = function()
	--			vim.lsp.config('ols', { capabilities = caps })
	--			vim.lsp.enable('ols')
	--			vim.lsp.config('zls', {
	--				settings = {
	--					zls = {
	--						semantic_token = "partial",
	--						enable_build_on_save = true
	--					}
	--				}
	--			})
	--			vim.lsp.enable('zls')
	--
	--			vim.lsp.enable('lua_ls');
	--
	--			vim.lsp.config('clangd', {  })
	--			vim.lsp.enable('clangd');
	--
	--			local configs = require("lspconfig.configs")
	--			if not configs.jails then
	--				configs.jails = {
	--					default_config = {
	--						cmd = { "/Users/oliverjorgensen/Tools/Jails/bin/jails" },
	--						-- root_dir = vim.lsp.config.util.root_pattern("jails.json", "build.jai", "main.jai"),
	--						filetypes = { "jai" },
	--						name = "Jails",
	--					},
	--				}
	--			end
	--			vim.lsp.enable('jails')
	--			vim.filetype.add({ extension = { jai = "jai", } })
	--
	--		end,
	--	}
	--}
}
