local format_on_save_enabled = true

local toggle_format_on_save = function()
    format_on_save_enabled = not format_on_save_enabled
    if format_on_save_enabled then
        print("Format on Save: Enabled")
    else
        print("Format on Save: Disabled")
    end
end

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
                json = { "prettier", lsp_format = "fallback" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
            },
            format_on_save = function(_)
                if format_on_save_enabled then
                    return {
                        timeout_ms = 2000,
                        lsp_format = "fallback", -- use language server as fallback
                    }
                end
            end,
            -- Conform will notify you when a formatter errors
            notify_on_error = true,
            -- Conform will notify you when no formatters are available for the buffer
            notify_no_formatters = true,
            formatters = {
                -- the following config is not needed currently, the prettier config is read correctly.
                -- I'll leave it in as backup for now
                prettier = {
                    command = "prettier",
                    args = { "--stdin-filepath", "$FILENAME" },
                    condition = function(_, ctx)
                        -- do not format markdown files in gp.nvim chats saved  in
                        -- ~/.local/share/nvim/gp/chats/ (see gp.lua)
                        if (string.find(ctx.filename, "/nvim/gp/chats")) then
                            return false
                        end

                        return true
                        -- this makes sure, the prettier config is read correctly
                        -- HOW? This just returns false if no prettier config is available
                        -- return vim.fn.filereadable(".prettierrc") == 1 or vim.fn.filereadable(".prettierrc.json") == 1 or
                        -- vim.fn.filereadable(".prettierrc.js") == 1
                    end,
                },
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
            log_level = vim.log.levels.TRACE
        })

        vim.keymap.set("n", "<F3>", function()
            conform.format({ async = true, lsp_format = "never" })
        end, { desc = "Format with Conform" })

        vim.keymap.set("n", "<leader>p", function()
            conform.format({ async = true, lsp_format = "fallback" })
        end, { desc = "Format with Conform and LSP Fallback" })

        vim.keymap.set("n", "<S-F3>", toggle_format_on_save, { desc = "Toggle Format on Save" })

        vim.api.nvim_create_user_command('ToggleFormatOnSave', function()
            toggle_format_on_save()
        end, {})
    end
}
