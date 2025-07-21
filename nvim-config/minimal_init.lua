-- Set leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Sensible settings
vim.opt.number = true             -- Show line numbers
vim.opt.mouse = "a"               -- Enable mouse support
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.expandtab = true          -- Convert tabs to spaces
vim.opt.shiftwidth = 4            -- Indentation width
vim.opt.tabstop = 4               -- Tab width
vim.opt.softtabstop = 4           -- Spaces per tab in insert mode
vim.opt.smartindent = true        -- Enable smart indentation
vim.opt.autoindent = true        -- Enable smart indentation
vim.opt.ai = true        -- Enable smart indentation
vim.opt.wrap = false              -- Disable line wrapping
vim.opt.swapfile = false          -- Disable swap files
vim.opt.backup = false            -- Disable backups
vim.opt.undofile = true           -- Enable persistent undo
vim.opt.ignorecase = true         -- Case-insensitive search...
vim.opt.showmatch = true
vim.opt.splitbelow = true
vim.opt.smartcase = true          -- ...unless search contains uppercase
vim.opt.hlsearch = true           -- Highlight search results
vim.opt.incsearch = true          -- Show search matches while typing
vim.opt.scrolloff = 8             -- Keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8         -- Keep 8 columns visible left/right of cursor
vim.opt.cursorline = true
vim.opt.termguicolors = true      -- Enable true color support
vim.opt.signcolumn = "yes"        -- Always show sign column to avoid shifting
vim.opt.wildmenu = true
vim.opt.foldmethod = "indent"  -- Fold based on indentation
vim.opt.foldenable = false     -- Don't fold by default, open files normally

vim.cmd("colorscheme habamax")
