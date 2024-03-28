vim.keymap.set("n", "<leader>n", ":lua MiniFiles.open()<cr>", { noremap = true, silent = true })

return {
    'echasnovski/mini.files',
    version = false,
    config = function(_, opts)
        require("mini.files").setup(opts)
    end,
    opts = {
        mappings = {
            synchronize = 'S',
        }
    }
}
