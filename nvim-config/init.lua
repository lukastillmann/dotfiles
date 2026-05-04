-- setup base options and keymaps
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- defer LSP config until after plugins load — vim.lsp.config/enable only need to
-- run before the first BufReadPost, VeryLazy fires safely before that
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    once = true,
    callback = function()
        require("core.lsp")
        require("core.gitlab")
        require("util.notes")
    end,
})

-- bootstrap lazy.nvim and plugins
require("config.lazy")
