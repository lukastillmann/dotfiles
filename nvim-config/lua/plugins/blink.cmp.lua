return {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
    },
    version = '1.*',
    config = function()
        require('blink.cmp').setup({
            keymap = {
                preset = 'none', -- options: "enter" ] "super-tab" | "default" | "none" to set your own

                ['<Tab>'] = { 'select_next', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'fallback' },
                ['<CR>'] = { 'accept', 'fallback' },

                -- Optional: for better UX
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide' },

                -- Keep arrow keys as alternative navigation
                ['<Up>'] = { 'select_prev', 'fallback' },
                ['<Down>'] = { 'select_next', 'fallback' },
            },
            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = {
                documentation = { auto_show = true },
                -- trigger = {
                --     prefetch_on_insert = false
                -- }
                menu = {
                    draw = {
                        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 2 } }
                    }
                },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false,
                    }
                }
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {},
            },
            fuzzy = { implementation = "lua" },
            signature = {
                enabled = true
            }
        })
    end,
    opts_extend = { "sources.default" }
}
