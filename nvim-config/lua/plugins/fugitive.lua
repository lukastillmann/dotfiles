---
--- fugitive.vim: A Git wrapper so awesome, it should be illegal
---
--- source: https://github.com/tpope/vim-fugitive
---
return {
    "tpope/vim-fugitive",
    config = function()
        -- wslview is a utility to allow opening urls in the windows browser
        -- necessary for GBrowse on wsl
        -- https://wslutiliti.es/wslu/man/wslview.html
        -- vim.g.netrw_browsex_viewer = "wslview"
    end
}
