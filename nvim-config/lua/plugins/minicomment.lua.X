vim.cmd([[map // gcc]]) -- could not get this mapping to work with lua

return {
	"echasnovski/mini.comment",
	event = "VeryLazy",
	opts = {
		hooks = {
			pre = function()
				require("ts_context_commentstring.internal").update_commentstring({})
			end,
		},
	},
	config = function(_, opts)
		require("mini.comment").setup(opts)
	end,
}
