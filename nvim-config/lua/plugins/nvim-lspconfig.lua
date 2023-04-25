return { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = "BufReadPre",
    dependencies = {
         -- Automatically install LSPs to stdpath for neovim
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",

         -- Useful status updates for LSP
        { "j-hui/fidget.nvim", config = true },
    },
    config = function(plugin)
        require("plugins.lsp.servers").setup(plugin)
    end,
    opts = {
        capabilities = {},
        autoformat = true,
        servers = {
        },
    }
}
