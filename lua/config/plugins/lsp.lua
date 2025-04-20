return {
	{
		"ziglang/zig.vim",
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			'saghen/blink.cmp',
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			local caps = require('blink.cmp').get_lsp_capabilities()
			require("lspconfig").ols.setup { capabilities = caps }
			require("lspconfig").zls.setup {
				capabilities = caps,
				settings = {
					zls = {
						semantic_token = "partial",
						enable_build_on_save = true
					}
				}
			}
			require("lspconfig").rust_analyzer.setup { capabilities = caps }

			require("lspconfig").lua_ls.setup { capabilities = caps }
			require("lspconfig").clangd.setup { capabilities = caps, cmd = { "clangd", "--fallback-style=webkit" } }

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
				end,
			})
		end,
	}
}
