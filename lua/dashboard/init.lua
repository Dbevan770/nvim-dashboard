local M = {}

function M.setup()
	-- Automatically open the dashboard when Neovim starts with an empty buffer
	vim.api.nvim_create_autocmd("VimEnter", {
		pattern = "*",
		callback = function()
			if vim.fn.argc() == 0 and vim.fn.line2byte("$") == -1 then
				M.open_dashboard()
			end
		end,
	})
end

function M.open_dashboard()
	-- Stored global options
	local global_number = vim.api.nvim_get_option("number")
	local global_relativenumber = vim.api.nvim_get_option("relativenumber")

	-- Clear the buffer and set some basic content
	vim.api.nvim_buf_set_lines(0, 0, -1, false, { "Welcome to my Dashboard", "More features coming soon!" })

	-- Set window options
	vim.api.nvim_win_set_option(0, "number", false)
	vim.api.nvim_win_set_option(0, "relativenumber", false)

	-- Set buffer options to make it look like a Dashboard
	vim.api.nvim_buf_set_option(0, "buftype", "nofile")
	vim.api.nvim_buf_set_option(0, "bufhidden", "hide")
	vim.api.nvim_buf_set_option(0, "readonly", true)
	vim.api.nvim_buf_set_option(0, "swapfile", false)

	-- Reset line number and relative line number settings to the user's settings when leaving
	-- the buffer
	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = 0,
		callback = function()
			vim.api.nvim_set_option("number", global_number)
			vim.api.nvim_set_option("relativenumber", global_relativenumber)
		end,
	})
end

return M
