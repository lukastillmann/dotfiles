------
--- https://github.com/SmiteshP/nvim-navbuddy
---
--- A simple popup display that provides breadcrumbs feature using LSP server
------

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "SmiteshP/nvim-navbuddy",
            dependencies = {
                "SmiteshP/nvim-navic",
                "MunifTanjim/nui.nvim"
            },
            opts = { lsp = { auto_attach = true } }
        }
    },
    config = function()
        vim.keymap.set('n', 'gn', '<cmd>:Navbuddy<cr>')
    end
}
