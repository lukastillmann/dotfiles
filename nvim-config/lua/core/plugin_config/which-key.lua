require("which-key").setup()

vim.api.nvim_set_keymap("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { noremap = true })
