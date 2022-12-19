-----------------------------------------------------------
-- Install Plugin Manager and Plugins
-----------------------------------------------------------

local fn = vim.fn

local ensure_packer = function()
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
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

require("packer").startup(function(use)
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

  -----------------------------------------------------------
  -- Autocomplection
  -----------------------------------------------------------

  use {
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }

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

  -----------------------------------------------------------
  -- Fizzy Finder / Telescope
  -----------------------------------------------------------

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }


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


