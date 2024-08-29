--[[
Snippet Engine for Neovim written in Lua.

Source: https://github.com/L3MON4D3/LuaSnip
--]]

return {
    "L3MON4D3/LuaSnip",
    build = (not jit.os:find("Windows"))
        and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
        or nil,
    version = "2.*",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    config = function()
        -- Ensure LuaSnip is configured correctly
        require("luasnip").config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
        })
        -- Load friendly-snippets
        require("luasnip.loaders.from_vscode").lazy_load()
    end
}
