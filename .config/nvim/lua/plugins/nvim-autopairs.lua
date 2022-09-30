-----------------------------------------------------------
-- Nvim Autopairs configuration file
-----------------------------------------------------------

-- Plugin nvim-autopairs
-- https://github.com/windwp/nvim-autopairs

local status_ok, npairs = pcall(require, 'nvim-autopairs')
if not status_ok then
    return
end

-- Configuration for coq_nvim
-- see https://github.com/windwp/nvim-autopairs

local remap = vim.api.nvim_set_keymap

npairs.setup({
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
      java = false,
    },
    map_bs = false,
    map_cr = false
  }
)

vim.g.coq_settings.keymap = { recommended = false }

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end

remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
