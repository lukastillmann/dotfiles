require("spectre").setup()

-- Helper function to automatically set keymap options
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

map("n", "<leader>s", require("spectre").open)
--  map("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")
