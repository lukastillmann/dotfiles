return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate", -- :MasonUpdate updates registry contents
	cmd = "Mason",
	keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
	ensure_installed = {
		--		"vue-language-server",
		--        "eslint_d",
	},
	config = function(plugin)
		require("mason").setup()
		local mr = require("mason-registry")
		for _, tool in ipairs(plugin.ensure_installed) do
			local p = mr.get_package(tool)
			if not p:is_installed() then
				p:install()
			end
		end
	end,
}
