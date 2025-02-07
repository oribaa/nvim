vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")

vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd.colorscheme "rose-pine"
vim.opt.compatible = false
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.undofile = true

vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":.lua<CR>")

vim.keymap.set("n", "sv", ":vsplit<CR><C-W><C-L>")
vim.keymap.set("n", "sh", ":split<CR><C-W><C-J>")

vim.keymap.set("n", "<leader>EE", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix" })
vim.keymap.set("n", "<leader>ee", "<cmd>Telescope diagnostics bufnr=0<CR>")

vim.keymap.set("n", "<leader><leader>n", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader><leader>p", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader><leader>l", "<cmd>copen<CR>")
vim.keymap.set("n", "<leader><leader>L", "<cmd>ccl<CR>")

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd('TermOpen', {
	group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
		vim.cmd.startinsert()
	end,
})

vim.keymap.set("n", "<leader>st", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("L")
end)

vim.keymap.set("n", "<leader>bo", function()
	vim.cmd.new()
	vim.cmd.term()
	vim.cmd.wincmd("L")
	vim.fn.chansend(vim.bo.channel, { "odin run . -debug -o:none\r\n" })
end)
vim.keymap.set("n", "<leader>bc", function()
	vim.cmd.new()
	vim.cmd.term()
	vim.cmd.wincmd("L")
	vim.fn.chansend(vim.bo.channel, { "sh build.sh\r\n" })
end)
vim.keymap.set("n", "<leader>bz", function()
	vim.cmd.new()
	vim.cmd.term()
	vim.cmd.wincmd("L")
	vim.fn.chansend(vim.bo.channel, { "zig build --summary failures --color on run\r\n" })
end)
