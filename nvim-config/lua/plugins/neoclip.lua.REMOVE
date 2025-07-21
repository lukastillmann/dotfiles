return {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
        -- you'll need at least one of these
        { 'nvim-telescope/telescope.nvim' },
        -- {'ibhagwan/fzf-lua'},
    },
    config = function()
        require('neoclip').setup()
    end,
    keys = {
        { "<leader>cc", mode = { "n" }, "<cmd>Telescope neoclip<cr>", desc = "Open Neoclip" }
    }
}
