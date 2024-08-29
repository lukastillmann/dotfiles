-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroupo

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    group = "YankHighlight",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = "200" })
    end,
})

-- Remove whitespace on save
-- autocmd('BufWritePre', {
--   pattern = '*',
--   command = ":%s/\\s\\+$//e"
-- })

-- disable auto commenting new lines
-- autocmd('BufEnter', {
--   pattern = '*',
--   command = 'set fo-=c fo-=r fo-=o'
-- })

-- enable correct auto-intending for comments in vue files
autocmd("FileType", {
    pattern = "vue",
    command = "set fo=croq",
})

-- enable format on save for js files
-- autocmd('BufEnter', {
--  pattern = "*.tsx,*.ts,*.js,*.vue",
--  command = "LspToggleAutoFormat"
--})

-- enable correct auto-indenting for comments in vue files
-- vim.cmd("autocmd FileType vue set fo=croq")

-- Run EslintFixAll on save
--vim.cmd("autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js,*.vue EslintFixAll")

-- Show line diagnostics automatically in hover window
vim.cmd([[
  autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
]])
