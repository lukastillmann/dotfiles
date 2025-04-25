return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup({
            adapters = {
                qwen = function()
                    return require("codecompanion.adapters").extend("ollama", {
                        name = "qwen",
                        schema = {
                            model = {
                                default = "qwen2.5-coder:14b-adapted",
                            },
                        },
                    })
                end,
                openai = function()
                    return require("codecompanion.adapters").extend("openai", {
                        name = "openai",
                        schema = {
                            model = {
                                default = "gpt-4o"
                            },
                            api_key = {
                                default = os.getenv("OPENAI_API_KEY")
                            }
                        }
                    })
                end
            },
            strategies = {
                chat = {
                    adapter = "qwen",
                },
                inline = {
                    adapter = "qwen",
                },
                agent = {
                    adapter = "qwen",
                },
            },
            display = {
                diff = {
                    enabled = true,
                    provider = "mini_diff"
                }
            }
        })
    end,
}
