return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			'theHamsta/nvim-dap-virtual-text',
			"nvim-neotest/nvim-nio",
			"folke/lazydev.nvim"
		},
		config = function()
			require("lazydev").setup({
				library = { "nvim-dap-ui" }
			})
			require("dapui").setup({
				mappings = {
					edit = "E",
					expand = { "e", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					repl = "r",
					toggle = "t"
				},
				layouts = {
					{
						elements = { {
							id = "repl",
							size = 0.33
						}, {
							id = "scopes",
							size = 0.33
						},
							{
								id = "stacks",
								size = 0.33
							}
						},
						position = "bottom",
						size = 12
					}
				}
			})
			require("nvim-dap-virtual-text").setup()

			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
			vim.keymap.set("v", "<leader>de", "<Cmd>lua require('dapui').eval()<CR>")

			vim.keymap.set('n', '<leader>dd', function()
				dap.terminate()
				dapui.close()
			end)
			vim.keymap.set('n', '<leader>dc', function() dap.continue() end)
			vim.keymap.set('n', '<leader>ds', function() dap.step_over() end)
			vim.keymap.set('n', '<leader>di', function() dap.step_into() end)
			vim.keymap.set('n', '<leader>do', function() dap.step_out() end)
			vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end)
			vim.keymap.set('n', '<Leader>dp',
				function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
			vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
			vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
			vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
				require('dap.ui.widgets').hover()
			end)
			vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
				require('dap.ui.widgets').preview()
			end)
			vim.keymap.set('n', '<Leader>df', function()
				local widgets = require('dap.ui.widgets')
				widgets.centered_float(widgets.frames)
			end)
			vim.keymap.set('n', '<Leader>ds', function()
				local widgets = require('dap.ui.widgets')
				widgets.centered_float(widgets.scopes)
			end)

			dap.adapters.lldb = {
				type = 'executable',
				command = '/Applications/Xcode.app/Contents/Developer/usr/bin/lldb-dap',
				name = 'lldb'
			}
			dap.configurations.cpp = {
				{
					name = 'Launch',
					type = 'lldb',
					request = 'launch',
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = '${workspaceFolder}',
					stopOnEntry = false,
					args = {},

					-- 💀
					-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
					--
					--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
					--
					-- Otherwise you might get the following error:
					--
					--    Error on launch: Failed to attach to the target process
					--
					-- But you should be aware of the implications:
					-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
					-- runInTerminal = false,
				},
			}

			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp
			dap.configurations.jai = dap.configurations.cpp
		end
	}
}
