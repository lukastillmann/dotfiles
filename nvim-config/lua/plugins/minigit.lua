return {
    'nvim-mini/mini-git',
    version = false,
    main = "mini.git",
    opts = {},
    keys = {
        {
            "<leader>gh",
            "<cmd>lua require('mini.git').show_range_history()<cr>",
            mode = { "n", "x" },
            desc = "Git range history"
        },
        {
            "<leader>gs",
            "<cmd>lua require('mini.git').show_at_cursor()<cr>",
            desc = "Git show at cursor"
        },
    },
}
