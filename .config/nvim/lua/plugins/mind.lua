-----------------------------------------------------------
-- mind.nvim configuration file
----------------------------------------------------------

-- Plugin: mind.nvim
-- url: https://github.com/phaazon/mind.nvim

local status_ok, mind = pcall(require, "mind")
if not status_ok then
  return
end

mind.setup()
