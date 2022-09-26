-----------------------------------------------------------
-- Plugins / Packer
-----------------------------------------------------------

local fn = vim.fn

 -- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  -- snapshot = "july-24",
  snapshot_path = fn.stdpath "config" .. "/snapshots",
  max_jobs = 50,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
    prompt_border = "rounded", -- Border style of prompt popups.
  },
}

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'


  -- Editor
  use 'feline-nvim/feline.nvim'           -- statusbar
  use 'morhetz/gruvbox'                   -- vim colortheme
  use 'kshenoy/vim-signature'             -- toggle/display/navigate marks
  use 'honza/vim-snippets'                -- adds default snippets
  use 'farmergreg/vim-lastplace'          -- reopen files at last edit position
--  use 'preservim/nerdcommenter'           -- comments
  use 'numToStr/Comment.nvim'             -- commenting
  use 'pablopunk/persistent-undo.vim'     -- allows undoing changes even after editor is closed and re-opened
  use {
	"windwp/nvim-autopairs",              -- autoclose brackets and other characters
    config = function() require("nvim-autopairs").setup {} end
  }
  use "andymass/vim-matchup"              -- use % to navigate to matching text
  use "karb94/neoscroll.nvim"             -- smooth scrolling
  use "junegunn/vim-slash"                -- better behavior when searching with /
  -- use "heavenshell/vim-jsdoc"

  use "jghauser/mkdir.nvim"               -- automatically create missing directories

  -- Terminal
  use "akinsho/toggleterm.nvim"

  -- enables seamless copy pasting between vim and wsl
  use 'christoomey/vim-system-copy'

  -- Syntax Highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"     -- set commentstring based on location in file (e.g. in vue sfc)
  use "windwp/nvim-ts-autotag"              -- autoclose and autorename html tags
--  use { 'leafoftree/vim-vue-plugin' }
  use { 'ap/vim-css-color' }                -- show css colors
  use {
    "abecodes/tabout.nvim",                 -- tabout of brackets etc.
    wants = { "nvim-treesitter" }, -- or require if not used so far
  }

  -- Prettier
  use { 'prettier/vim-prettier', run = 'yarn install --frozen-lockfile --production' }

  -- LSP - Language Server Protocol
  use 'neovim/nvim-lspconfig'              -- Configurations for Nvim LSP
  use "williamboman/mason.nvim"            -- install and manage LSP servers and more
  use "williamboman/mason-lspconfig.nvim"
  use "jose-elias-alvarez/null-ls.nvim"    -- for formatters and linters
  use "ray-x/lsp_signature.nvim"           -- Show function signature when you type
  use "RRethy/vim-illuminate"              -- highlighting words for lsp
  use "j-hui/fidget.nvim"                  -- Standalone UI for nvim-lsp progress.
  use "https://git.sr.ht/~whynothugo/lsp_lines.nvim"  -- renders diagnostics using virtual lines
  use "lvimuser/lsp-inlayhints.nvim"       -- lsp inlay hints

  -- Autocompletion
  -- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#coq_nvim
  -- if installing dependencies with :COQdeps does not work, try installing 'apt-get install python3-venv'
  use { 'ms-jpq/coq_nvim', run = 'python3 -m coq deps' }
  use 'ms-jpq/coq.artifacts'
  use 'ms-jpq/coq.thirdparty'

  -- Utility
  use "rcarriga/nvim-notify"                -- notification manager
  use "stevearc/dressing.nvim"              -- improve neovim core ui hooks
  use "ghillb/cybu.nvim"                    -- open buffer management (like CTRL-Tab on windows)
--  use "moll/vim-bbye"
  use "lewis6991/impatient.nvim"            -- improve startup time with caching

  -- extendable fuzzy finder over lists
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- fuzzy finder for Telescope
  use {'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }

  -- File browser
  use { "nvim-telescope/telescope-file-browser.nvim" }

  -- Telescope ui for code actions
  use {'nvim-telescope/telescope-ui-select.nvim' }

  -- Markdown
  use {"ellisonleao/glow.nvim", branch = 'main'}

  -- Icons
  use 'kyazdani42/nvim-web-devicons'

  -- Glow-hover
  use 'JASONews/glow-hover'

  -- Git
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'
  use 'f-person/git-blame.nvim'             -- git glame inlay lines
  use "lewis6991/gitsigns.nvim"

  -- Tmux
  -- use 'christoomey/vim-tmux-navigator'

  -- Project
  use 'ahmedkhalf/project.nvim'

  -- Note Taking
  use {
    'phaazon/mind.nvim',
    branch = 'v2.2',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  --use { 'tomarrell/vim-npr' }             -- sensible name path resolution for node projects (resolve modules using gf)

  -- vim-rooter. A high performance plugin to change your working directory to the project root when you open a file
  -- not needed anymore because of project.nvim
--[[ 	use {
		 'notjedi/nvim-rooter.lua',
		 config = function() require'nvim-rooter'.setup({ rooter_patterns = { '=src' }} ) end
	} ]]

   -- Secure load local config files.
   use {
     "klen/nvim-config-local",
     config = function()
       require('config-local').setup {
         -- Default configuration (optional)
         config_files = { ".vimrc.lua", ".vimrc" },  -- Config file patterns to load (lua supported)
         hashfile = vim.fn.stdpath("data") .. "/config-local", -- Where the plugin keeps files data
         autocommands_create = true,                 -- Create autocommands (VimEnter, DirectoryChanged)
         commands_create = true,                     -- Create commands (ConfigSource, ConfigEdit, ConfigTrust, ConfigIgnore)
         silent = false,                             -- Disable plugin messages (Config loaded/ignored)
         lookup_parents = false,                     -- Lookup config files in parent directories
       }
     end
   }

  -- Start Screen
--[[   use {
    "startup-nvim/startup.nvim",
    requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
  } ]]
  use 'echasnovski/mini.nvim'

   -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end

end)
