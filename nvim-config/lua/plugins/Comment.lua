vim.cmd([[map // gcc]]) -- could not get this mapping to work with lua

return {
	"numToStr/Comment.nvim",
	opts = {},
	config = function(_, opts)
		require("Comment").setup(opts)
	end,
}
