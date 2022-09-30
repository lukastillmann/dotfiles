local map = vim.api.nvim_set_keymap

-- Automatically start coq
vim.g.coq_settings = {
    auto_start = 'shut-up',
    keymap = {
        jump_to_mark = "<c-x>" -- because the default <c-h> is used for switching panes
    }
}


-- Enable some language servers with the additional completion capabilities offered by coq_nvim
--local lspconfig = require('lspconfig')
--local servers = { 'tsserver', 'volar' }
--for _, lsp in ipairs(servers) do
  --lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({
    ---- on_attach = my_custom_on_attach,
  --}))
--end

map('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
map('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
map('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
map('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })
