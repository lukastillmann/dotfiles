return {
    "williamboman/mason-lspconfig.nvim",
    config = function()
        local lsp_zero = require("lsp-zero")
        local opts = {
            ensure_installed = { "lua_ls", "tsserver", "volar", "pyright", "jsonls", "stylelint_lsp" },
            handlers = {
                lsp_zero.default_setup
            }
        }
        require("mason-lspconfig").setup(opts)
    end
}
