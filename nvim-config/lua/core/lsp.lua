-- Get the correct location for typescript library
-- local os_name = vim.loop.os_uname().sysname
-- local tspath
--
-- -- linux
-- if os_name == "Linux" then
--     tspath = "/home/lukas/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib/"
--     -- macOS
-- elseif os_name == "Darwin" then
--     tspath = "/Users/lukas/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib/"
-- end

local default_keymaps = {
    { keys = "K",          func = vim.lsp.buf.hover,       desc = "Documentation",   has = "hoverProvider" },
    { keys = "gd",         func = vim.lsp.buf.definition,  desc = "Goto Definition", has = "definitionProvider" },
    { keys = "<leader>ca", func = vim.lsp.buf.code_action, desc = "Code Actions" },
    { keys = "<F4>",       func = vim.lsp.buf.code_action, desc = "Code Actions" },
    -- { keys = "<leader>.",  func = vim.lsp.buf.code_action, desc = "Code Actions" },
    -- { keys = "<leader>cA", func = M.action.source,         desc = "Source Actions" },
    { keys = "<F2>",       func = vim.lsp.buf.rename,      desc = "Code Rename" },
    { keys = "K",          func = vim.lsp.buf.hover,       desc = "Documentation",   has = "hoverProvider" },
    { keys = "gr",         func = vim.lsp.buf.references,  desc = "References" }
}

local on_attach = function(client, bufnr)
    for _, keymap in ipairs(default_keymaps) do
        if not keymap.has or client.server_capabilities[keymap.has] then
            vim.keymap.set(keymap.mode or "n", keymap.keys, keymap.func, {
                buffer = bufnr,
                desc = "LSP: " .. keymap.desc,
                nowait = keymap.nowait,
            })
        end
    end
end

-- this doesn't work apparently..
-- vim.lsp.config("*", {
--     on_attach = on_attach
-- })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        on_attach(client, args.buf)
    end,
})

-- configure vue_ls to work with typescript
-- source: https://github.com/vuejs/language-tools/wiki/Neovim
local vue_language_server_path = vim.fn.stdpath('data') ..
    "/mason/packages/vue-language-server/node_modules/@vue/language-server"
local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }

local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = vue_language_server_path,
    languages = { 'vue' },
    configNamespace = 'typescript',
}

local ts_ls_config = {
    init_options = {
        plugins = {
            vue_plugin,
        },
    },
    filetypes = tsserver_filetypes,
}

local lua_ls_config = {
    settings = {
        Lua = {
            diagnostics = {
                -- disabled undefined global warning in lua files
                globals = {
                    "vim"
                }
            }
        }
    }
}

local vue_ls_config = {}

vim.lsp.config("vue_ls", vue_ls_config)
vim.lsp.config("ts_ls", ts_ls_config)
vim.lsp.config("lua_ls", lua_ls_config)

vim.lsp.enable({
    "lua_ls",
    "ts_ls",
    "eslint",
    "pyright",
    "html",
    "cssls",
    "vue_ls",
})
