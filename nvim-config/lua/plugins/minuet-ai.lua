return {
    {
        'milanglacier/minuet-ai.nvim',
        config = function()
            require('minuet').setup {
                -- Your configuration options here
                provider = "claude", -- Try this
                claude = {
                    api_key = os.getenv("ANTHROPIC_API_KEY"),
                    model = "claude-3-5-sonnet-20241022",
                },
                request_timeout = 3
            }
        end,
    },
    { 'nvim-lua/plenary.nvim' },
    -- optional, if you are using virtual-text frontend, blink is not required.
    { 'Saghen/blink.cmp' },
}
