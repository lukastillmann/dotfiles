return {
    "prettier/vim-prettier",
    build = "npm install",
    config = function()
        vim.api.nvim_set_keymap("n", "<F3>", "<cmd>Prettier<cr>", {
            desc = "Prettier"
        })
    end,
}
