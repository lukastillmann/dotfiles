-----------------------------------------------------------
-- Install Plugin Manager and Plugins
-----------------------------------------------------------

local fn = vim.fn

local ensure_packer = function()
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -----------------------------------------------------------
  -- LSP
  -----------------------------------------------------------

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',
    },
  }

  -- Null-ls provides access to language servers not natively supported by neovim
  --use 'jose-elias-alvarez/null-ls.nvim'

  -- when native lsp fails to format js files correctly, this can be used as a backup
  use 'MunifTanjim/prettier.nvim'

  -- Show function signature when you type
  use "ray-x/lsp_signature.nvim"

  -----------------------------------------------------------
  -- Autocomplection
  -----------------------------------------------------------

  use {
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }

  -----------------------------------------------------------
  -- Snippets
  -----------------------------------------------------------

  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use "rafamadriz/friendly-snippets" -- Snippets collection

  -----------------------------------------------------------
  -- Treesitter - Highlight, edit, and navigate code
  -----------------------------------------------------------

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -----------------------------------------------------------
  -- File Browser
  -----------------------------------------------------------

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    }
  }

  use "beauwilliams/focus.nvim"

  -----------------------------------------------------------
  -- Git related Plugins
  -----------------------------------------------------------

  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  -----------------------------------------------------------
  -- Colorschemes
  -----------------------------------------------------------

  use 'ellisonleao/gruvbox.nvim'
  use 'navarasu/onedark.nvim' -- Theme inspired by Atom

  -----------------------------------------------------------
  -- Editor Improvements
  -----------------------------------------------------------

  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  use 'folke/which-key.nvim' -- display a popup with possible key bindings

  use "andymass/vim-matchup" -- use % to navigate to matching text
  use "karb94/neoscroll.nvim" -- smooth scrolling
  use 'pablopunk/persistent-undo.vim' -- allows undoing changes even after editor is closed and re-opened
  use 'farmergreg/vim-lastplace' -- reopen files at last edit position
  use "junegunn/vim-slash" -- better behavior when searching with /
  use "jghauser/mkdir.nvim" -- automatically create missing directories
  use "windwp/nvim-autopairs" -- autoclose brackets and other characters


  -----------------------------------------------------------
  -- Fuzzy Finder / Telescope
  -----------------------------------------------------------

  -- Fuzzy Finder (files, lsp, etc)
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", 'nvim-lua/plenary.nvim' }
  }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  use { 'nvim-telescope/telescope-ui-select.nvim' }

  use { 'aaronhallaert/advanced-git-search.nvim',
    requires = { "nvim-telescope/telescope.nvim", "tpope/vim-fugitive" }
  }

  -----------------------------------------------------------
  -- Misc
  -----------------------------------------------------------

  use 'numToStr/Navigator.nvim'
  -- enables seamless copy pasting between vim and wsl
  use 'christoomey/vim-system-copy'
  use {
    'AckslD/messages.nvim',
    config = 'require("messages").setup()',
  }

  -- Markdown Previwer
  use { "ellisonleao/glow.nvim" }

  use({
    "jackMort/ChatGPT.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  })

  use 'eandrju/cellular-automaton.nvim'

  use 'stevearc/aerial.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Have packer use a popup window
--require('packer').init {
-- snapshot = "july-24",
--  snapshot_path = fn.stdpath "config" .. "/snapshots",
--  max_jobs = 50,
--  display = {
--    open_fn = function()
--      return require("packer.util").float { border = "rounded" }
--    end,
--    prompt_border = "rounded", -- Border style of prompt popups.
--  },
--}
