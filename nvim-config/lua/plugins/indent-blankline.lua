--[[
This plugin adds indentation guides to all lines (including empty lines).

It uses Neovim's virtual text feature and no conceal

Source: https://github.com/lukas-reineke/indent-blankline.nvim
--]]

return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		-- char = "▏",
		char = "│",
		filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
		show_trailing_blankline_indent = false,
		show_current_context = false,
	},
}
