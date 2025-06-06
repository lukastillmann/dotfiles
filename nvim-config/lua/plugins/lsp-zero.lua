----------------------------------------------------------
-- A starting point to setup some lsp related features in neovim.
-- --
-- Source: https://github.com/VonHeikemen/lsp-zero.nvim
----------------------------------------------------------

return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    config = function()
        local lsp_zero = require('lsp-zero')

        -- lsp_attach is where you enable features that only work
        -- if there is a language server active in the file
        local lsp_attach = function(_, bufnr)
            local opts = { buffer = bufnr }

            vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
            vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
            vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
            vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
            vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
            vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
            vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
            vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
            -- vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
            vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
            vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end

        lsp_zero.extend_lspconfig({
            sign_text = true,
            lsp_attach = lsp_attach,
            capabilities = require('cmp_nvim_lsp').default_capabilities()
        })

        -- Get the correct location for typescript library
        local os_name = vim.loop.os_uname().sysname
        local tspath

        -- linux
        if os_name == "Linux" then
            tspath = "/home/lukas/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib/"
            -- macOS
        elseif os_name == "Darwin" then
            tspath = "/Users/lukas/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib/"
        end

        ------
        --- Format on Save
        --- INFO format_on_save is now provided by conform.lua plugin
        -------
        -- lsp_zero.format_on_save({
        --     format_opts = {
        --         async = false,
        --         timeout_ms = 10000,
        --     },
        --     -- configure filetype for each available lsp server
        --     -- that should use auto-formatting on save
        --     servers = {
        --         ["eslint"] = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro" },
        --         ["lua_ls"] = { "lua" },
        --         ["jsonls"] = { "json" },
        --         ["pyright"] = { "python" },
        --         ["html"] = { "html" }
        --     }
        -- })
        --
        ------
        --- Language Servers
        -------

        require('lspconfig').lua_ls.setup(lsp_zero.nvim_lua_ls())
        require('lspconfig').ts_ls.setup({})
        require("lspconfig").eslint.setup({})
        require("lspconfig").volar.setup({
            init_options = {
                vue = {
                    -- LSP Featues in Vue files currently only work when hybrIdMode is set to false
                    -- I dont know why
                    --
                    -- see https://github.com/vuejs/language-tools/issues/4339
                    hybridMode = false,
                },
                typescript = {
                    -- setting the typescript location manually prevents "Can't find typescript.js or tsserverlibrary.js" errors
                    tsdk = tspath
                }
            }
        })
        require("lspconfig").pyright.setup({})
        require('lspconfig').html.setup({})
        require("lspconfig").cssls.setup({})
    end
}

----------------------------------------------------------
-- DEBUG HELP
----------------------------------------------------------

--[[

-- ERROR: Volar client exited with a status of 1 (or similar)
--
-- SOLUTION:
-- cd ~/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server
-- npm install  @volar/language-core@2.4.0-alpha.20 @volar/language-server@2.4.0-alpha.20 @vue/language-core@2.0.29 @vue/language-server@2.0.29 @vue/language-service@2.0.29 @vue/typescript-plugin@
--
-- source: https://youtrack.jetbrains.com/issue/WEB-68756/Vue-LS-2.x-Couldnt-Start-server.watchFiles-is-not-a-function
--
-- EXPLANATION
--
-- seems to be an error with version 2.0.29 of the @vue/language-server package. Updateing the packages above works for now (2024-08-26)
--
-- ERROR: Can't find typescript.js or tsserverlibrary.js
--
-- SOLUTION:
-- set a global typescript path directly in the nvim config.
--        require("lspconfig").volar.setup({
            init_options = {
                  typescript = {
                    tsdk =
                    "/home/lukas/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib/"
                }
            }
        })
--
-- EXPLANATION:
--
-- Volar expects typesript to be installed in the workspace that was openened. If the project does not include typescript, this creates an error.
--]]
