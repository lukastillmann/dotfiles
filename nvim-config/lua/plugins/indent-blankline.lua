--[[
This plugin adds indentation guides to all lines (including empty lines).

It uses Neovim's virtual text feature and no conceal

Source: https://github.com/lukas-reineke/indent-blankline.nvim
--]]

return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        -- char = "▏",
        indent = {
            char = "│",
        },
    },
}
