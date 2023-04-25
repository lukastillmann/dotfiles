-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                       -- Enable mouse support
opt.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options
opt.path = vim.o.path .. "**"         -- search down into subfolders

opt.swapfile = false
vim.cmd([[colorscheme onedark]])

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true           -- Show line number
opt.showmatch = true        -- Highlight matching parenthesis
opt.splitbelow = true       -- Horizontal split to the bottom

-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true       -- Ignore case letters when search
opt.smartcase = true        -- Ignore lowercase for the whole pattern

--opt.linebreak = true        -- Wrap on word boundary
opt.laststatus=3            -- Set global statusline
opt.wildmenu=true           -- graphical autocomplete menu for files
opt.cursorline=true         -- highlight cursor line
opt.scrolloff=3             -- begin scrolling at 3 lines from the border of screen
opt.showtabline=2           -- always show tabline
opt.modelines=1             -- check first and last line for file specific configs
opt.cmdheight=1             -- set cmdheight to two lines
opt.incsearch=true
opt.hlsearch=true
opt.visualbell=true         -- disable beep sound

-----------------------------------------------------------
-- Folding
-----------------------------------------------------------

opt.foldmethod = 'indent'   -- Enable folding (default 'foldmarker')
opt.foldnestmax = 10
opt.foldlevelstart = 10

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true        -- Use spaces instead of tabs
opt.shiftwidth = 4          -- Shift 4 spaces when tab
opt.tabstop = 4             -- 1 tab == 4 spaces
opt.smartindent = true      -- Autoindent new lines
--opt.autoindent = true
--opt.ai = true

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true           -- Enable background buffers
opt.history = 100           -- Remember N lines in history
opt.lazyredraw = true       -- Faster scrolling
opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 300        -- ms to wait for trigger an event
vim.cmd("set updatetime=300") -- fallback, if line above doesn't work
