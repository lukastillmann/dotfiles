-----------------------------------------------------------
-- Language Server Configs
-----------------------------------------------------------

-- LSP settings.
--
-- do not let volar do the formatting, it does not respect
-- .prettierrc settings
function Format()
    vim.lsp.buf.format({
        filter = function(client)
            return client.name ~= "volar"
        end,
    })
end

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('<leader>gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    --nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = 'Format current buffer with LSP' })

    if (client.name ~= "volar")
    then
        nmap('<leader>f', ':Format<cr>', '[F]ormat buffer using LSP')
    end
end



-- Setup mason so it can manage external tooling
require('mason').setup()

-- Enable the following language servers
local servers = { 'pyright', 'lua_ls', 'volar', 'bashls', 'eslint', 'jsonls' }

-- Ensure the servers above are installed
require('mason-lspconfig').setup {
    ensure_installed = servers,
}

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for client, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

-- Turn on lsp status information
require('fidget').setup()

-----------------------------------------------------------
-- Language specific configs
-----------------------------------------------------------

-- Enable "Take Over Mode" for volar
require('lspconfig').volar.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' }
}

-- Eslint
require('lspconfig').eslint.setup {
    on_attach = function(_, bufnr)
        -- lint on save
        -- use EslintFixAll. Native lsp formatting (above) does not respect prettier rules
        local group = vim.api.nvim_create_augroup("Eslint", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = group,
            pattern = "*.tsx,*.ts,*.jsx,*.js,*.vue",
            command = "EslintFixAll",
            desc = "Run eslint when saving buffer.",
        })

        vim.keymap.set('n', '<leader>f', ':EslintFixAll<cr>', { buffer = bufnr, desc = '[F]ormat buffer using eslint' })
    end
}

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = { library = vim.api.nvim_get_runtime_file('', true) },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false },
        },
    },
}
