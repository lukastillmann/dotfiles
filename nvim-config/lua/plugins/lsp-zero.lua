local Util = require("util")

return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },             -- Required
        { 'williamboman/mason.nvim' },           -- Optional
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },     -- Required
        { 'hrsh7th/cmp-nvim-lsp' }, -- Required
        { 'L3MON4D3/LuaSnip' },     -- Required
    },
    config = function()
        local lsp = require("lsp-zero")
        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

        -------
        --- Setup Presets
        -------
        lsp.on_attach(function(_, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp.default_keymaps({ buffer = bufnr })

            local opts = {
                buffer = bufnr
            }

            -- setup custom keymaps
            vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
            vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
            vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
            vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
            vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
            vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
            vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end)

        ------
        --- Format on Save
        -------
        lsp.format_on_save({
            format_opts = {
                async = false,
                timeout_ms = 10000,
            },
            -- configure filetype for each available lsp server
            -- that should use auto-formatting on save
            servers = {
                ["eslint"] = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro" },
                ["lua_ls"] = { "lua" },
                ["jsonls"] = { "json" },
                ["pyright"] = { "python" },
                ["html"] = { "html" }
            }
        })


        ------
        --- tsserver (Javascript, Typescript)
        -------

        require('lspconfig').tsserver.setup({
            capabilities = lsp_capabilities,
            on_attach = function(_, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end,
            on_init = function(client)
                -- disable formatting
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentFormattingRangeProvider = false
            end,
        })

        ------
        --- Volar
        -------

        require('lspconfig').volar.setup({
            capabilities = lsp_capabilities,
            on_attach = function(_, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end,
            on_init = function(client)
                -- disable formatting
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentFormattingRangeProvider = false
            end,
        })

        -------
        --- eslint
        -------

        require("lspconfig").eslint.setup({
            capabilities = lsp_capabilities,
            on_attach = function(_, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end,

        })

        ------
        --- Lua
        -------

        require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

        ------
        --- HTML
        --- source: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html
        ------
        local html_capabilities = vim.lsp.protocol.make_client_capabilities()
        html_capabilities.textDocument.completion.completionItem.snippetSupport = true

        require('lspconfig').html.setup({
            capabilities = html_capabilities,
        })

        ------
        --- CSS/SASS
        ------

        require("lspconfig").cssls.setup({
            capabilities = lsp_capabilities,
            on_attach = function(_, bufnr)
                -- use Prettier on save
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    command = "Prettier",
                })
                lsp.default_keymaps({ buffer = bufnr })
            end,
        })

        require("lspconfig").stylelint_lsp.setup({
            capabilities = lsp_capabilities,
            on_attach = function(_, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end,
            root_dir = require("lspconfig").util.root_pattern(".git", "package.json"),
            settings = {
                stylelintplus = {
                    -- see available options in stylelint-lsp documentation
                }
            }
        })

        ------
        --- Python
        -------

        require("lspconfig").pyright.setup({
            capabilities = lsp_capabilities,
            on_attach = function(_, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end,
        })

        ------
        --- JSON
        -------

        -- works but causes errors atm :-(
        -- require('lspconfig').jsonls.setup()
        --]]
    end
}
