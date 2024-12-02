return {
    'stevearc/conform.nvim',
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier", lsp_format = "never" },
                typescript = { "prettier", lsp_format = "never" },
                javascriptreact = { "prettier", lsp_format = "never" },
                typescriptreact = { "prettier", lsp_format = "never" },
                vue = { "prettier", lsp_format = "never" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
            },
            format_on_save = {
                timeout_ms = 1000,
                lsp_format = "fallback" -- use language server as fallback
            },
            formatters = {
                -- the following config is not needed currently, the prettier config is read correctly.
                -- I'll leave it in as backup for now
                -- prettier = {
                --     command = "prettier",
                --     args = { "--stdin-filepath", "$FILENAME" },
                --     condition = function()
                --         -- this makes sure, the prettier config is read correctly
                --         return vim.fn.filereadable(".prettierrc") == 1 or vim.fn.filereadable(".prettierrc.json") == 1 or
                --             vim.fn.filereadable(".prettierrc.js") == 1
                --     end,
                -- },
                -- prettierd = {
                --     command = "prettierd",
                --     args = { "--stdin-filepath", "$FILENAME" },
                --     condition = function()
                --         -- this makes sure, the prettier config is read correctly
                --         return vim.fn.filereadable(".prettierrc") == 1 or vim.fn.filereadable(".prettierrc.json") == 1 or
                --             vim.fn.filereadable(".prettierrc.js") == 1
                --     end,
                -- },
            },
            -- log_level = vim.log.levels.TRACE
        })

        vim.keymap.set("n", "<F3>", function()
            conform.format({ async = true, lsp_format = "never" })
        end, { desc = "Format with Conform" })

        vim.keymap.set("n", "<leader>p", function()
            conform.format({ async = true, lsp_format = "fallback" })
        end, { desc = "Format with Conform and LSP Fallback" })
    end
}
