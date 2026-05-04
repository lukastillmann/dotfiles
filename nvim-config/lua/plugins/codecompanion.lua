return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat" },
    keys = {
        { "<leader>ca", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanion Actions" },
        { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion Chat" },
        { "<leader>ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "CodeCompanion Add" },
    },
    config = function()
        local function patch_mcphub_codecompanion_compat()
            local ok, variables = pcall(require, "mcphub.extensions.codecompanion.variables")
            if not ok or variables._cc_editor_context_compat then
                return
            end

            local register = variables.register
            variables.register = function(opts)
                local config_ok, config = pcall(require, "codecompanion.config")
                if config_ok then
                    config.interactions = config.interactions or {}
                    config.interactions.chat = config.interactions.chat or {}
                    config.interactions.chat.editor_context = config.interactions.chat.editor_context or {}
                    config.interactions.chat.variables = config.interactions.chat.variables
                        or config.interactions.chat.editor_context
                end

                return register(opts)
            end
            variables._cc_editor_context_compat = true
        end

        patch_mcphub_codecompanion_compat()

        vim.cmd([[cab cc CodeCompanion]])

        require("codecompanion").setup({
            interactions = {
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
                http = {
                    anthropic = function()
                        return require("codecompanion.adapters").extend("anthropic", {
                            env = {
                                api_key = "cmd:cat ~/secrets/anthropic",
                            },
                        })
                    end,
                    -- overwrite ollama, for some reason this seems to be necessary
                    ollama = function()
                        return require("codecompanion.adapters").extend("openai_compatible", {
                            env = {
                                url = "http://localhost:1234",
                            },
                        })
                    end,
                },
                acp = {
                    claude_code = function()
                        return require("codecompanion.adapters").extend("claude_code", {
                            env = {
                                ANTHROPIC_API_KEY = "cmd:cat ~/secrets/anthropic",
                            },
                        })
                    end,
                    gemini_cli = function()
                        return require("codecompanion.adapters").extend("gemini_cli", {
                            defaults = {
                                auth_method = "oauth-personal"
                            },
                            -- env = {
                            --     api_key = "GEMINI_API_KEY",
                            -- },
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
                log_level = "INFO", -- TRACE|DEBUG|ERROR|INFO
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
                        alias = "quickhelp",
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
                        alias = "code_comment",
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
                        alias = "expert",
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
