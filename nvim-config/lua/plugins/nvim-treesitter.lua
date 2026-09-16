-------------
--- Nvim Treesitter configurations and abstraction layer
--- Treesitter: Syntax tree for source files
---
--- Sourcer: https://github.com/nvim-treesitter/nvim-treesitter
-------------

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            require("nvim-treesitter").install({
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
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "bash",
                    "sh",
                    "c",
                    "css",
                    "scss",
                    "html",
                    "javascript",
                    "json",
                    "lua",
                    "markdown",
                    "python",
                    "query",
                    "typescript",
                    "typescriptreact",
                    "vim",
                    "vue",
                    "yaml",
                },
                callback = function()
                    vim.treesitter.start()
                end,
            })
        end,
    },
}
