return {
	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = { signs = false }
	},
	{
		'junegunn/goyo.vim',
		config = function()
			vim.g.goyo_width = 120
			vim.keymap.set("n", "<leader>$", "<cmd>Goyo<CR>")
		end
	},
	{
		'echasnovski/mini.statusline',
		version = false,
		config = function()
			require('mini.statusline').setup()
		end
	}
}
