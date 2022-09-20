-----------------------------------------------------------
-- Color schemes configuration file
-----------------------------------------------------------

-- load colorscheme 'gruvbox'
--local status_ok, color_scheme = pcall(require, 'gruvbox')
--if not status_ok then
--  return
--end

vim.g.gruvbox_italic = 1
vim.cmd([[colorscheme gruvbox]])
vim.o.background = 'dark'
