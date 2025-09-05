return {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
        'milanglacier/minuet-ai.nvim',
    },
    version = '1.*',
    config = function()
        require('blink.cmp').setup({
            keymap = {
                preset = 'none', -- options: "enter" ] "super-tab" | "default" | "none" to set your own
                -- ['<A-y>'] = require('minuet').make_blink_map(),

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
                }
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    minuet = {
                        name = 'minuet',
                        module = 'minuet.blink',
                        async = true,
                        timeout_ms = 3000,
                        score_offset = 50,
                    },
                },
            },
            fuzzy = { implementation = "lua" },
            signature = {
                enabled = true
            }
        })
    end,
    opts_extend = { "sources.default" }
}
