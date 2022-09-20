-- [[
--Neovim init file
-- ]]

-- Website: https://github.com/brainfucksec/neovim-lua

-- Import modules

require("core/helper")
require("packer_init")
require("core/options")
require("core/startup")
require("core/colors")
require("core/autocmds")
require("core/keymaps")
require("core/statusline")

require("plugins/lsp/init")

--require("plugins/nvim-lspconfig")
require("plugins/notify")
require("plugins/fidget")
require("plugins/nvim-treesitter")
require("plugins/telescope")
require("plugins/vim-system-copy")
require("plugins/gitsigns")
require("plugins/lsp-inlayhints")
require("plugins/coq_nvim")
require("plugins/vim-jsdoc")
require("plugins/glow-hover")
require("plugins/nvim-autopairs")
require("plugins/comment")
require("plugins/project")
require("plugins/nvim-rooter")
require("plugins/impatient")
require("plugins/cybu")
require("plugins/matchup")
require("plugins/neoscroll")
require("plugins/git-blame")
require("plugins/illuminate")
require("plugins/dressing")
require("plugins/tabout")
require("plugins/vim-slash")
require("plugins/nvim-web-devicons")
require("plugins/toggleterm")
