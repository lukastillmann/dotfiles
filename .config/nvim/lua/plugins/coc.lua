vim.api.nvim_set_keymap("n", "<leader>.", "<Plug>(coc-codeaction)", {})
vim.api.nvim_set_keymap("n", "<leader>a", ":CocCommand eslint.executeAutofix<CR>", {})
vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", {silent = true})
vim.api.nvim_set_keymap("n", "K", ":call CocAction('doHover')<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>rn", "<Plug>(coc-rename)", {})
vim.api.nvim_set_keymap("n", "<leader>f", ":CocCommand prettier.formatFile<CR>", {noremap = true})
vim.api.nvim_set_keymap("i", "<C-Space>", "coc#refresh()", { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<TAB>", "pumvisible() ? '<C-n>' : '<TAB>'", {noremap = true, silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<S-TAB>", "pumvisible() ? '<C-p>' : '<C-h>'", {noremap = true, expr = true})
vim.api.nvim_set_keymap("i", "<CR>", "pumvisible() ? coc#_select_confirm() : '<C-G>u<CR><C-R>=coc#on_enter()<CR>'", {silent = true, expr = true, noremap = true})
-- use F9 to trigger prettier
vim.api.nvim_set_keymap("n", "<F9>", ":CocCommand prettier.formatFile<CR>", {noremap = true})

vim.o.hidden = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 300

vim.g.coc_global_extensions  = { 'coc-tsserver', 'coc-json', 'coc-html', 'coc-prettier' , 'coc-snippets', 'coc-pairs', 'coc-eslint', 'coc-sumneko-lua', 'coc-svg', 'coc-docker', 'coc-sh' }
vim.g.coc_node_path = "/home/lukas/.nvm/versions/node/v18.5.0/bin/node"
