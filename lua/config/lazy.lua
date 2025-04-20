-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ "rose-pine/neovim",       name = "rose-pine" },
		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			opts = {},
			config = function() end,
		},
		{
			"zenbones-theme/zenbones.nvim",
			-- Optionally install Lush. Allows for more configuration or extending the colorscheme
			-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
			-- In Vim, compat mode is turned on as Lush only works in Neovim.
			dependencies = "rktjmp/lush.nvim",
			lazy = false,
			priority = 1000,
			-- you can set set configuration options here
			-- config = function()
			--     vim.g.zenbones_darken_comments = 45
			--     vim.cmd.colorscheme('zenbones')
			-- end
		},
		{ import = "config.plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "zenbones" } },
	-- automatically check for plugin updates
	checker = { enabled = true, notify = false },
})
