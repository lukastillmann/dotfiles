---------------------------------------------------------------------------------
--- Navigator.nvim provides set of functions and commands that allows you to
--- seamlessly navigate between neovim and different terminal multiplexers.
---
---Source: https://github.com/numToStr/Navigator.nvim
---------------------------------------------------------------------------------

return {
	"numToStr/Navigator.nvim",
	opts = function()
		vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
		vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
		vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
		vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")
		vim.keymap.set({ "n", "t" }, "<C-p>", "<CMD>NavigatorPrevious<CR>")
	end,
}
