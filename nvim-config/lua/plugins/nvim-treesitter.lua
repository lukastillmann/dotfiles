-------------
--- Nvim Treesitter configurations and abstraction layer
--- Treesitter: Syntax tree for source files
---
--- Sourcer: https://github.com/nvim-treesitter/nvim-treesitter
-------------

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            local opts = {
                ensure_installed = {
                    "bash",
                    "c",
                    "css",
                    "scss",
                    "html",
                    "javascript",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "query",
                    "regex",
                    "tsx",
                    "typescript",
                    "vim",
                    "vue",
                    "yaml",
                },
                highlight = { enable = true },
            }
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
