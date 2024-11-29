--[[
Automatically expand width of the current window. Maximizes and restore it. And all this with nice animations!

Source: https://github.com/anuvyklack/windows.nvim_lsp

--]]

return {
    "anuvyklack/windows.nvim",
    dependencies = {
        "anuvyklack/middleclass",
        -- "anuvyklack/animation.nvim" -- add animations
    },
    config = function()
        vim.o.winwidth = 10
        vim.o.winminwidth = 10
        vim.o.equalalways = false
        require('windows').setup()
    end
}
