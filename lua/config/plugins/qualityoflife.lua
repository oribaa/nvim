return {
	{
		'f-person/auto-dark-mode.nvim',
		opts = {
			set_dark_mode = function()
				print("Setting dark mode...")
				vim.cmd.colorscheme "xcodedarkhc"
			end,
			set_light_mode = function()
				print("Setting light mode...")
				vim.cmd.colorscheme "xcodelighthc"
			end,
			fallback = "light"
		},
	},
	{
		'rluba/jai.vim',
		config = function()
		end
	},
	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = { signs = false }
	},
	{
		'junegunn/goyo.vim',
		config = function()
			vim.g.goyo_width = 120
			vim.keymap.set("n", "<leader>`", "<cmd>Goyo<CR>")
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
