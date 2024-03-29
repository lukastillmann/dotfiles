return {
	"folke/trouble.nvim",
	requires = "nvim-tree/nvim-web-devicons",
	config = function()
		require("trouble").setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		})
	end,
	keys = {
		{ "<leader>t", "<cmd>TroubleToggle<cr>", desc = "[T]rouble" },
	},
}
