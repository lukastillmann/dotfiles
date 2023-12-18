return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs              = {
            add          = { text = '+' },
            change       = { text = '~' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~-' },
            untracked    = { text = '┆' },
        },
        signcolumn         = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl              = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl             = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff          = false, -- Toggle with `:Gitsigns toggle_word_diff`
        current_line_blame = true,  -- Toggle with `:Gitsigns toggle_current_line_blame`
        --      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    }
}
