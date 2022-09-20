-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local M = {}

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
vim.g.mapleader = ','

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Map Esc to kk
map('i', 'kk', '<Esc>')

-- Clear search highlighting with <leader> and c
map('n', '<leader>c', ':nohl<CR>')

-- Toggle auto-indenting for code paste
map('n', '<F2>', ':set invpaste paste?<CR>')
vim.opt.pastetoggle = '<F2>'

-- comments
--map("", "//", "gcc") -- doesn't work any more for some reason.. use gcc instead

-- increment/decrement number with Alt-a/Alt-x
-- because Ctrl-a is used by tmux
map("n", "<A-a>", "<C-a>")
map("n", "<A-x>", "<C-x>")

-- Reload configuration without restart nvim
-- conflict with <leader>rn to rename
--map('n', '<leader>r', ':so %<CR>')

-- Fast saving with <leader> and s
map('n', '<leader>s', ':w<CR>')
map('i', '<leader>s', '<C-c>:w<CR>')

-- Close all windows and exit from Neovim with <leader> and q
map('n', '<leader>q', ':qa!<CR>')

-- reset syntax highlighting in vue files
map("n", "<C-s>", ":syntax sync fromstart<CR>")

-- use F9 to trigger prettier
map("n", "<F9>", ":Prettier<CR>")

-----------------------------------------------------------
-- Splits and Panes (Neovim and Tmux)
-----------------------------------------------------------

-- Change split orientation
map('n', '<leader>tk', '<C-w>t<C-w>K') -- change vertical to horizontal
map('n', '<leader>th', '<C-w>t<C-w>H') -- change horizontal to vertical

-- resize panes with arrow keys
map("n", "<Right>", ":vertical resize +5<cr>")
map("n", "<Left>", ":vertical resize -5<cr>")
map("n", "<Up>", "resize +5<cr>")
map("n", "<Down>", "resize -5<cr>")

-- split tmux panes
map("n", "<C-W><C-J>", "<C-W>s<C-W><C-J>")
map("n", "<C-W><C-K>", "<C-W>s<C-W><C-K>")
map("n", "<C-W><C-L>", "<C-W>v<C-W><C-L>")
map("n", "<C-W><C-H>", "<C-W>v<C-W><C-H>")

-- split vim panes
map("n", "<leader>l", ":vsplit<cr><C-W><C-L>")
map("n", "<leader>j", ":split<cr><C-W><C-J>")
map("n", "<leader>h", ":vsplit<cr>")
map("n", "<leader>k", ":split<cr>")

-- Keymaps for find with splits
map("n", "vfind", "vert sfind")
map("n", "f", "find")
map("n", "sf", "sfind")
vim.cmd('cabbrev vsf vert sfind')
vim.cmd('cabbrev f find')
vim.cmd('cabbrev sf sfind')

-----------------------------------------------------------
-- Tabs
-----------------------------------------------------------

map("n", "<leader>t", ":tabnew %<cr>")
map("n", "<leader>y", ":tabclose<cr>")
map("n", "<m-\\>", ":tabonly<cr>")

-----------------------------------------------------------
-- Terminal
-----------------------------------------------------------

-- map("n", "<c-t>", ":ToggleTerm<cr>") -- toggleterm.nvim plugin

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-----------------------------------------------------------
-- LSP Keymaps
-- These must be called in the on_attach function, therefore we export them here
-- they are imported and used in plugins.lsp.mason.lua
-----------------------------------------------------------

local format = function(payload)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name ~= "volar"
    end,
  })
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap

  keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)

  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
  -- keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>Telescope diagnostics<CR>", opts)

  -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]]

  -- keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "<M-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  keymap(bufnr, "n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
  keymap(bufnr, "n", "<leader>f", "<cmd>LspFormat<CR>", opts)
  -- keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

  -- keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  -- keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  -- keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

M.lsp_keymaps = lsp_keymaps

return M
