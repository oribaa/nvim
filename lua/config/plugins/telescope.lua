return {
	{
		'nvim-telescope/telescope.nvim',
		tag = "0.1.8",
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = "make" }
		},
		config = function()
			require('telescope').setup {
				pickers = {
					find_files = {
						theme = "dropdown"
					}
				},
				extensions = {
					fzf = {}
				}
			}
			require('telescope').load_extension('fzf')

			vim.keymap.set("n", "<leader>fg", require('telescope.builtin').live_grep)
			vim.keymap.set("n", "<leader>fh", require('telescope.builtin').help_tags)
			vim.keymap.set("n", "<leader>fb", require('telescope.builtin').buffers)
			vim.keymap.set("n", "<leader>ff", require('telescope.builtin').find_files)

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func)
						vim.keymap.set('n', keys, func, { buffer = event.buf })
					end
					map("gr", require('telescope.builtin').lsp_references)
					map("gd", require('telescope.builtin').lsp_definitions)
					map("gD", vim.lsp.buf.declaration)
					map("gi", require('telescope.builtin').lsp_implementations)
					map("gt", require('telescope.builtin').lsp_type_definitions)
					map("ga", vim.lsp.buf.rename)
					map("gA", vim.lsp.buf.code_action)
					map("K", vim.lsp.buf.hover)
				end
			})

			-- GIT RELATED STUFF TO USE
			vim.keymap.set("n", "<leader>fgis", require('telescope.builtin').git_status)
			vim.keymap.set("n", "<leader>fgib", require('telescope.builtin').git_branches)

			vim.keymap.set("n", "<leader>ed", function()
				require('telescope.builtin').find_files {
					cwd = vim.fn.stdpath("config")
				}
			end)
		end
	}
}
