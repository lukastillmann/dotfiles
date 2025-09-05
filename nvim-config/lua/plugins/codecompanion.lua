return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
        vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>",
            { noremap = true, silent = true })
        vim.keymap.set("v", "<leader>ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

        -- Expand 'cc' into 'CodeCompanion' in the command line
        vim.cmd([[cab cc CodeCompanion]])

        require("codecompanion").setup({
            strategies = {
                chat = {
                    adapter = "anthropic",
                },
                inline = {
                    adapter = "anthropic",
                },
                agent = {
                    adapter = "anthropic",
                },
            },
            adapters = {
                acp = {
                    gemini_cli = function()
                        return require("codecompanion.adapters").extend("gemini_cli", {
                            env = {
                                api_key = "GEMINI_API_KEY",
                            },
                        })
                    end,
                },
            },
            display = {
                diff = {
                    enabled = true,
                    provider = "mini_diff"
                }
            },
            opts = {
                log_level = "INFO",                   -- TRACE|DEBUG|ERROR|INFO
            },
            extensions = {
                mcphub = {
                    callback = "mcphub.extensions.codecompanion",
                    opts = {
                        show_result_in_chat = true, -- Show mcp tool results in chat
                        make_vars = true,           -- Convert resources to #variables
                        make_slash_commands = true, -- Add prompts as /slash commands
                    }
                }
            },
            prompt_library = {
                ["QuickHelp"] = {
                    strategy = "chat",
                    description = "Quick responses and short answers",
                    opts = {
                        short_name = "quickhelp",
                        auto_submit = false,
                        ignore_system_prompt = true
                    },
                    prompts = {
                        {
                            role = "system",
                            content =
                            [["You are a concise and expert coding assistant for a frontend project using Vue 3, TypeScript, Vite, and SCSS/CSS. Your guidelines:

- Keep answers short and precise — no filler, no elaboration unless explicitly asked.
- Assume the user is an experienced developer.
- Do not include long code snippets unless the user explicitly requests them. Use minimal examples where needed.
- If something is not recommended or possible, say so clearly and briefly.
- If something is ambiguous, ask questions to make sure your responses are correct.
- Include a one sentence Summary in markdown quote format at the end of your response.
"]]
                        },
                        {
                            role = "user",
                            content = "Help me with this file. Give a one or two sentence answer. #buffer"
                        }
                    },
                },
                ["CodeComments"] = {
                    strategy = "chat",
                    description = "Add Code comments",
                    opts = {
                        short_name = "code_comment",
                        auto_submit = true,
                    },
                    prompts = {
                        {
                            role = "system",
                            content = function(context)
                                return "I want you to act as a senior "
                                    .. context.filetype
                                    .. " developer. I will ask you specific questions and I want you to return concise explanations and codeblock examples."
                            end,
                        },
                        {
                            role = "user",
                            content = "Write a comment block above every function you can see. #buffer"
                        }
                    }

                },
                ["Code Expert"] = {
                    strategy = "chat",
                    description = "Get some special advice from an LLM",
                    opts = {
                        mapping = "<leader>ce",
                        modes = { "v" },
                        short_name = "expert",
                        auto_submit = true,
                        stop_context_insertion = true,
                        user_prompt = true,
                    },
                    prompts = {
                        {
                            role = "system",
                            content = function(context)
                                return "I want you to act as a senior "
                                    .. context.filetype
                                    .. " developer. I will ask you specific questions and I want you to return concise explanations and codeblock examples."
                            end,
                        },
                        {
                            role = "user",
                            content = function(context)
                                local text = require("codecompanion.helpers.actions").get_code(context.start_line,
                                    context.end_line)

                                return "I have the following code:\n\n```" ..
                                    context.filetype .. "\n" .. text .. "\n```\n\n"
                            end,
                            opts = {
                                contains_code = true,
                            }
                        },
                    },
                },
            }
        })
    end,
}
