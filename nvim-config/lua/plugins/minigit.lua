return {
    'nvim-mini/mini-git',
    version = false,
    config = function(_, opts)
        require("mini.git").setup(opts)
    end,
}
