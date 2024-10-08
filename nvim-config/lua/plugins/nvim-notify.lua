--------------------------------------------------------------------------
--- A fancy, configurable, notification manager for NeoVim
---
--- Source: https://github.com/rcarriga/nvim-notify
--------------------------------------------------------------------------

local Util = require("util")

return {
    "rcarriga/nvim-notify",
    enabled = true,
    keys = {
        {
            "<leader>dn",
            function()
                require("notify").dismiss({ silent = true, pending = true })
            end,
            desc = "Delete all Notifications",
        },
    },
    opts = {
        timeout = 2000,
        render = "minimal",
        top_down = false, -- set to false to position messages on the bottom
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
        end,
    },
    init = function()
        -- when noice is not enabled, install notify on VeryLazy
        Util.on_very_lazy(function()
            vim.notify = require("notify")
        end)
    end,
}
