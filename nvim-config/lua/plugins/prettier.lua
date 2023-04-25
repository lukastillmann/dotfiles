  -- when native lsp fails to format js files correctly, this can be used as a backup
return {
    'MunifTanjim/prettier.nvim',
    bin = 'prettier', -- or `'prettierd'` (v0.22+)
    filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
        "vue",
      },
}
