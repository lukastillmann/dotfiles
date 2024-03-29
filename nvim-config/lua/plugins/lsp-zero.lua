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
            servers = {
                ['eslint'] = { 'javascript', 'vue', 'typescript' },
                ['lua_ls'] = { 'lua' },
                ['jsonls'] = { 'json' }
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
        --- JSON
        -------

        -- works but causes errors atm :-(
        -- require('lspconfig').jsonls.setup()
        --]]
    end

    --[[
    config = function()
        local lsp = require("lsp-zero")
        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

        -------
        --- Setup Presets
        -------
        lsp.preset("recommended")
        lsp.on_attach(function(_, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp.default_keymaps({ buffer = bufnr })
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
            servers = {
                ['eslint'] = { 'javascript', 'vue' },
                ['lua_ls'] = { 'lua' },
            }
        })

        ------
        --- Lua
        -------

        require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

        ------
        --- Volar
        -------

        -- require('lspconfig').volar.setup({
        --     capabilities = lsp_capabilities,
        --     on_attach = function(_, bufnr)
        --         lsp.default_keymaps({ buffer = bufnr })
        --     end,
        -- })



        ------
        --- tsserver (Javascript, Typescript)
        -------

        require('lspconfig').tsserver.setup({
            capabilities = lsp_capabilities,
            on_attach = function(_, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end,
        })

        ------
        --- Setup lsp-zero
        -------

        lsp.setup()
        vim.diagnostic.config { virtual_text = true }
    end
    --]]
}
--[[
	config = function(_, opts)
        local lsp = require('lsp-zero').preset({})

        lsp.on_attach(function(client, bufnr)
          -- see :help lsp-zero-keybindings
          -- to learn the available actions
          lsp.default_keymaps({buffer = bufnr})
        end)

        -- (Optional) Configure lua language server for neovim
        require('lspconfig').tsserver.setup()

        lsp.setup()
    end
}
--]]
