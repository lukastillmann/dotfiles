-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------
-- Plugin: nvim-lspconfig
-- url: https://github.com/neovim/nvim-lspconfig
-- For configuration see the Wiki: https://github.com/neovim/nvim-lspconfig/wiki
local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then return end

-- Diagnostic options, see: `:help vim.diagnostic.config`
vim.diagnostic.config({
    update_in_insert = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = ""
    }
})

--[[

Language servers setup:

For language servers list see:
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

Language server installed:
Bash          -> bashls
Python        -> pyright
C-C++         -> clangd
HTML/CSS/JSON -> vscode-html-languageserver
JavaScript/TypeScript -> tsserver
--]]

-- Define `root_dir` when needed
-- See: https://github.com/neovim/nvim-lspconfig/issues/320
-- This is a workaround, maybe not work with some servers.
local root_dir = function() return vim.fn.getcwd() end

-- List of language servers: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches.
-- local servers = { 'bashls', 'tsserver', 'volar', 'eslint_d', 'html', 'cssls', 'jsonls' }
local servers = {'tsserver', 'volar', 'pyright', 'eslint'}

-- Call setup
for _, server in ipairs(servers) do
    opts = {
        on_attach = require("plugins.lsp.handlers").on_attach,
        capabilities = require("plugins.lsp.handlers").capabilities
    }

    server = vim.split(server, "@")[1]

    if server == "jsonls" then
        local jsonls_opts = require "plugins.lsp.settings.jsonls"
        opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    end

    if server == "tsserver" then
        local tsserver_opts = require "plugins.lsp.settings.tsserver"
        opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
    end

    if server == "volar" then
        local volar_opts = require "plugins.lsp.settings.volar"
        opts = vim.tbl_deep_extend("force", volar_opts, opts)
    end

    if server == "eslint" then
        local eslint_opts = require "plugins.lsp.settings.eslint"
        opts = vim.tbl_deep_extend("force", eslint_opts, opts)
    end

    if server == "yamlls" then
        local yamlls_opts = require "plugins.lsp.settings.yamlls"
        opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
    end

    if server == "sumneko_lua" then
        local l_status_ok, lua_dev = pcall(require, "lua-dev")
        if not l_status_ok then return end
        local luadev = lua_dev.setup {
            -- add any options here, or leave empty to use the default settings
            -- lspconfig = opts,
            lspconfig = {
                on_attach = opts.on_attach,
                capabilities = opts.capabilities
                --   -- settings = opts.settings,
            }
        }
        lspconfig.sumneko_lua.setup(luadev)
        goto continue
    end

    if server == "pyright" then
        local pyright_opts = require "plugins.lsp.settings.pyright"
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    if server == "solc" then
        local solc_opts = require "plugins.lsp.settings.solc"
        opts = vim.tbl_deep_extend("force", solc_opts, opts)
    end

    if server == "emmet_ls" then
        local emmet_ls_opts = require "plugins.lsp.settings.emmet_ls"
        opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
    end

    lspconfig[server].setup(opts)

    ::continue::
end
