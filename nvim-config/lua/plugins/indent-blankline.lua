--[[
This plugin adds indentation guides to all lines (including empty lines).

It uses Neovim's virtual text feature and no conceal

Source: https://github.com/lukas-reineke/indent-blankline.nvim
--]]

return {
    "lukas-reineke/indent-blankline.nvim",
    -- tag = 'v3.8.2', -- update, when https://github.com/lukas-reineke/indent-blankline.nvim/issues/936 is fixed
    main = "ibl",
    opts = {
        indent = {
            char = "│",
        },
    },
}
