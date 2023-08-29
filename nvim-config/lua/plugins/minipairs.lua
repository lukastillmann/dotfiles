-- auto pairs
return {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
        mappings = {
            -- disable if there is an adjacent non-space character
            ["`"] = {
                action = "closeopen",
                pair = "``",
                neigh_pattern = "[^%S][^%S]",
                register = { cr = false }
            },
            ["("] = {
                action = "open",
                pair = "()",
                neigh_pattern = "[^%S][^%S]",
            }
        }
    },
    config = function(_, opts)
        require("mini.pairs").setup(opts)
    end,
}
