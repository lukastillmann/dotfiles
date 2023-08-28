-----------------------------------------------------------
-- Define keymaps of Neovim
-----------------------------------------------------------
-- Helper function to automatically set keymap options
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
vim.g.mapleader = ","

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

-- Toggle auto-indenting for code paste
-- map("n", "<F2>", ":set invpaste paste?<CR>")
-- vim.opt.pastetoggle = "<F2>" -- deprecated?

-- increment/decrement number with Alt-a/Alt-x
-- because Ctrl-a is used by tmux
map("n", "<A-a>", "<C-a>")
map("n", "<A-x>", "<C-x>")

-- add a console.log statement of the word under the cursor
map("n", "<leader>L", 'yiwoconsole.log("<Esc>pa", <Esc>pa);<Esc>')

-----------------------------------------------------------
-- Splits and Panes (Neovim and Tmux)
-----------------------------------------------------------

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
map("n", "<leader>j", ":new<cr><C-W><C-J>")
map("n", "<leader>h", ":vsplit<cr>")
map("n", "<leader>k", ":new<cr>")
