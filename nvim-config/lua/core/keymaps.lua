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
map("n", "<leader>C", 'yiwoconsole.log("<Esc>pa", <Esc>pa);<Esc>')
map("n", "<leader>L", 'yiwolog("<Esc>pa", <Esc>pa);<Esc>')

-- paste yanked content in line below
map('n', '<leader>P', 'o<Esc>P', { desc = "<P>aste yanked content in line blow" })

-- quickly move to template, script or style block in Vue files
map("n", "mt", '/<template><cr>:nohl<cr>', { desc = "<M>ove to <t>emplate tag" });
map("n", "ms", '/<script<cr>:nohl<cr>', { desc = "<m>ove to <sc>ript tag" });
map("n", "mst", '/<style<cr>:nohl<cr>', { desc = "<m>ove to <st>yle tag" });

map("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "open [d]iagnostic in float" })

-- disable F1 for help files (to prevent accidental hits)
map("n", "<F1>", "<Nop>")

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

map("n", "<C-l>r", "<cmd>LspRestart<cr>");

vim.api.nvim_create_user_command("FluidCleanup", function(opts)
    local start_line = opts.line1 - 1 -- Lua is 0-indexed
    local end_line = opts.line2       -- exclusive

    local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)

    for i, line in ipairs(lines) do
        line = line:gsub("fluid%-base", "fluid")
        line = line:gsub("fluid%-1%-pair", "fluid")
        line = line:gsub("fluid%-2%-pair", "fluid")
        line = line:gsub("role-space-fluid", "oon-space-fluid")
        line = line:gsub("role-shape-fluid", "oon-space-fluid")
        line = line:gsub("fluid-font-type", "fluid-font")
        line = line:gsub(",%s%d+px", "")
        line = line:gsub(",%s%d+px", "")
        lines[i] = line
    end

    vim.api.nvim_buf_set_lines(0, start_line, end_line, false, lines)
end, { range = true })
