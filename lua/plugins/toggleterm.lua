-----------------------------------------------------------
-- Toggleterm configuration flie
-----------------------------------------------------------

-- Plugin: toggleterm.nvim
-- url: https://github.com/akinsho/toggleterm.nvim

local M = {}

local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

-- setup separate terminal for lazygit
local Terminal  = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

toggleterm.setup({
    direction = "float",
    open_mapping = [[<c-t>]],
})

M._lazygit_toggle = _lazygit_toggle
return M
