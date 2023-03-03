-----------------------------------------------------------
-- Telescope Plugin Config
-----------------------------------------------------------

-- Helper function to automatically set keymap options
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

local telescope = require("telescope")

-- See `:help telescope` and `:help telescope.setup()`
telescope.setup {
  defaults = {
    mappings = {
      i = {
        -- ["<PageUp>"] = "preview_scrolling_up",
        -- ["<PageDown>"] = "preview_scrolling_down",
        ['<C-h>'] = "select_vertical",
        ['<C-j>'] = "select_horizontal",
      },
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      hidden = true
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      hijack_netrw = true
    },
    ["ui-select"] = {
      theme = "dropdown"
    },
  }
}

-----------------------------------------------------------
-- Extensions
-----------------------------------------------------------

-- Enable telescope fzf native, if installed
telescope.load_extension('fzf')

-- enable telescope file browser
telescope.load_extension('file_browser')

-- enable telescope for aerial
telescope.load_extension('aerial')

-- enable ui-select extension
telescope.load_extension('ui-select')

-- enable advanced_git_search extension
telescope.load_extension('advanced_git_search')

-----------------------------------------------------------
-- Keymaps
-----------------------------------------------------------

local builtin = require('telescope.builtin')
local extensions = require('telescope').extensions

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
map('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
map('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
map('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
map('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
map('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]resume last telescope' })
map('n', '<leader>n', extensions.file_browser.file_browser, { desc = "Open File Browser"})

-- git
map('n', '<leader>gb', builtin.git_branches, { desc = '[G]it [B]ranches'})
map('n', '<leader>gs', builtin.git_status, { desc = '[G]it [S]tatus'})

-- advanced git search extension
map('n', '<leader>gf', extensions.advanced_git_search.diff_commit_file, { desc = "[G]it commits for [F]ile" })
map('n', '<leader>gl', extensions.advanced_git_search.diff_commit_line, { desc = "[G]it commits for [L]ine"})

-- aerial
map('n', '<leader>a', extensions.aerial.aerial, { desc = 'Open [A]erial using telescope ' })
map('n', '<leader>A', require("aerial").toggle, { desc = 'Open [A]erial' })
