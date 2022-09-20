-----------------------------------------------------------
-- Nvim Telescope configuration file
-----------------------------------------------------------

-- Plugin: nvim-telescope
-- url: https://github.com/nvim-telescope/telescope.nvim

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

-----------------------------------------------------------
-- Helper
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local actions = require "telescope.actions"

-----------------------------------------------------------
-- Telescope Mappings
-----------------------------------------------------------

map('n', 'ff', "<cmd>lua require('telescope.builtin').find_files()<CR>")
map('n', 'fg', "<cmd>lua require('telescope.builtin').live_grep()<CR>")
map('n', 'fb', "<cmd>lua require('telescope.builtin').buffers()<CR>")
map('n', 'fh', "<cmd>lua require('telescope.builtin').help_tags()<CR>")
map('n', 'fs', "<cmd>lua require('telescope.builtin').grep_string()<CR>")

map("n", "gb", ":Telescope git_branches<CR>")
map("n", "gs", ":Telescope git_status<CR>")
map("n", "gf", ":Telescope git_files<CR>")

-- lsp features

--map('n', 'ga', "<cmd>lua require('telescope.builtin').diagnostics()<CR>")
map('n', 'gd', "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>")
map('n', 'gi', "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>")
map('n', 'gr', "<cmd>lua require('telescope.builtin').lsp_references()<CR>")
map('n', '<leader>d', "<cmd>lua require('telescope.builtin').diagnostics()<CR>")

-----------------------------------------------------------
-- Telescope Mappings
-----------------------------------------------------------

telescope.setup {

  extensions = {
    defaults = {
        mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
        },
        pickers = {
            live_grep = {
              theme = "dropdown",
            },
            grep_string = {
              theme = "dropdown",
            },
            find_files = {
              theme = "dropdown",
              previewer = false,
            },
            buffers = {
              theme = "dropdown",
              previewer = false,
              initial_mode = "normal",
            },
            planets = {
              show_pluto = true,
              show_moon = true,
            },
            colorscheme = {
              -- enable_preview = true,
            },
            lsp_references = {
              theme = "dropdown",
              initial_mode = "normal",
            },
            lsp_definitions = {
              theme = "dropdown",
              initial_mode = "normal",
            },
            lsp_declarations = {
              theme = "dropdown",
              initial_mode = "normal",
            },
            lsp_implementations = {
              theme = "dropdown",
              initial_mode = "normal",
            },
        }
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    }
  }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
