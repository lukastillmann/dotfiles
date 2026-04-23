--------------------------------------------------------------------------
--- Delete Neovim buffers without losing window layout
---
--- Source: https://github.com/famiu/bufdelete.nvim
--------------------------------------------------------------------------

return {
    "famiu/bufdelete.nvim",
    keys = {
        { "<leader>q", ":Bdelete<cr>",    desc = "Delete buffer without changing window layout" },
        { "<leader>Q", ":Bdelete!<cr>",   desc = "Force delete buffer without changing window layout" },
        { "<leader>0", ":%bd|e#|bd#<cr>", desc = "Close all buffers except current" },
        {
            -- "<leader>i",
            "<tab>",
            ":BufferLineCycleNext<cr>",
            desc = "Cycle through buffers right.",
        },
        {
            "<S-tab>",
            ":BufferLineCyclePrev<cr>",
            desc = "Cycle through buffers left.",
        },
    },
}
