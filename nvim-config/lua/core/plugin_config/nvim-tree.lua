-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  view = {
    mappings = {
      list = {
        { key = "<C-v>", action = "vsplit" }
      },
    },
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false
      }
    }
  }
})
