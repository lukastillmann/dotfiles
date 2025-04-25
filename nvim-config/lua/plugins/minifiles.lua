vim.keymap.set("n", "<leader>n", ":lua MiniFiles.open()<cr>", { noremap = true, silent = true })


return {
    'echasnovski/mini.files',
    version = false,
    config = function(_, opts)
        local MiniFiles = require("mini.files")
        MiniFiles.setup(opts)

        -- Set devlook bookmark
        -- see /util/notes.lua

        local set_mark = function(id, path, desc)
            MiniFiles.set_bookmark(id, path, { desc = desc })
        end

        local logbook_dir = os.getenv("LOGBOOK_DIR")
        vim.api.nvim_create_autocmd('User', {
            pattern = 'MiniFilesExplorerOpen',
            callback = function()
                set_mark('w', vim.fn.getcwd, 'Working directory') -- callable
                set_mark('l', logbook_dir, 'Logbook')
                set_mark('c', '~/dotfiles/nvim-config/lua', 'Neovim Config')
                set_mark('~', '~', 'Home directory')
            end,
        })
    end,
    opts = {
        mappings = {
            synchronize = 'S',
        }
    }
}
