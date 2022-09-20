return {
    filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
    -- The default config looks for typescript in the local node_modules. Use a global installation instead
    init_options = {
        typescript = {
            serverPath = '/home/lukas/.nvm/versions/node/v14.17.3/lib/node_modules/typescript/lib/tsserverlibrary.js'
        },
        eslint_d = {
            serverPath = '/home/lukas/.nvm/versions/node/v14.17.3/lib/node_modules/eslint_d/lib/linter.js'
        }

    }
}
