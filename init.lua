vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")

vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.compatible = false
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.o.termguicolors = false

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.undofile = true

vim.keymap.set("n", "<leader>w", ":w<CR>:w<CR>")

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

vim.keymap.set('t', '<C-w>h', [[<C-\><C-n><C-w>h]], { noremap = true, silent = true })
vim.keymap.set('t', '<C-w>l', [[<C-\><C-n><C-w>l]], { noremap = true, silent = true })
vim.keymap.set('t', '<C-w>k', [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
vim.keymap.set('t', '<C-w>j', [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })

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

local function open_term_and_run_cmd(cmd, always_new)
	always_new = always_new or false
	-- Search for an existing terminal buffer
	local term_buf = nil
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "terminal" then
			term_buf = buf
			break
		end
	end

	if not always_new and term_buf then
		-- Terminal exists; switch to it
		local term_win = nil
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_get_buf(win) == term_buf then
				term_win = win
				break
			end
		end
		if term_win then
			vim.api.nvim_set_current_win(term_win)
		else
			vim.cmd("vsplit")
			vim.api.nvim_win_set_buf(0, term_buf)
		end
	else
		-- No terminal found, open a new one on the right
		vim.cmd.new()
		vim.cmd.term()
		vim.cmd.wincmd("L")
		term_buf = vim.api.nvim_get_current_buf()
	end

	-- Send command to terminal
	local chan_id = vim.b.terminal_job_id
	if chan_id then
		vim.fn.chansend(chan_id, cmd .. "\n")
	end
end

vim.keymap.set("n", "<leader>bc", function()
	open_term_and_run_cmd("sh build.sh")
end)

--vim.keymap.set("n", "<leader>br", function()
--	local cd_to_cwd = "cd " .. vim.fn.getcwd() .. ""
--	local build_and_watch_cmd = cd_to_cwd ..
--		"&& zig build --watch"
--	os.execute("osascript -e 'tell application \"Terminal\" to do script \"" .. build_and_watch_cmd .. "\"'");
--end)

vim.keymap.set("n", "<leader>pp", function()
	open_term_and_run_cmd("!!\n")
end)

vim.keymap.set("n", "<leader>bb", function()
	open_term_and_run_cmd("jai build.jai")
end)
vim.keymap.set("n", "<leader>br", function()
	open_term_and_run_cmd("jai build.jai - reload")
end)
vim.keymap.set("n", "<leader>bt", function()
	open_term_and_run_cmd("jai build.jai - test")
end)

vim.keymap.set("n", "<leader>zz", function()
	open_term_and_run_cmd("zig build run")
end)
