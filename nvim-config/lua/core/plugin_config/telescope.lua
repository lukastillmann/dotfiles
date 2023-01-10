-----------------------------------------------------------
-- Telescope Plugin Config
-----------------------------------------------------------

-- Helper function to automatically set keymap options
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-h>'] = "select_vertical",
        ['<C-j>'] = "select_horizontal",
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-----------------------------------------------------------
-- Keymaps
-----------------------------------------------------------

local builtin = require('telescope.builtin')

-- See `:help telescope.builtin`
map('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
map('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

map('n', 'ff', builtin.find_files, { desc = '[F]ind [F]iles' })
map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
