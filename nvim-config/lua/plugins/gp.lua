----------------------------------------------------------
-- Gp.nvim (GPT prompt) Neovim AI plugin: ChatGPT sessions & Instructable text/code operations & Speech to text [OpenAI, Ollama, Anthropic, ..]
--
-- Source: https://github.com/Robitx/gp.nvim
-- ----------------------------------------------------------

local function keymapOptions(desc)
    return {
        noremap = true,
        silent = true,
        nowait = true,
        desc = "GPT prompt " .. desc,
    }
end

return {
    "robitx/gp.nvim",
    config = function()
        local conf = {
            -- For customization, refer to Install > Configuration in the Documentation/Readme
            openai_api_key = os.getenv("OPENAI_API_KEY"),
            log_sensitive = false,

            default_command_agent = nil,
            default_chat_agent = "ChatGPT4o",
            agents = {
                {
                    name = "ChatGPT4o",
                    chat = true,
                    command = true,
                    -- string with model name or table with model name and parameters
                    model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = "Act as a senior web developer mentoring a more junior dev.\n\n"
                        .. "The user provided the additional info about how they would like you to respond:\n\n"
                        .. "- If you're unsure don't guess and say you don't know instead.\n"
                        .. "- Ask question if you need clarification to provide better answer.\n"
                        .. "- Keep your answer short and concise. Use no more than one or two paragraphs of text.\n"
                        .. "- Give code examples whenever possible \n"
                },
            }
        }
        require("gp").setup(conf)

        -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)

        vim.keymap.set({ "n", "i" }, "<C-g>c", "<cmd>GpChatNew popup<cr>", keymapOptions("New Chat"))
        vim.keymap.set({ "n", "i" }, "<C-g>t", "<cmd>GpChatToggle popup<cr>", keymapOptions("Toggle Chat"))
        vim.keymap.set({ "n", "i" }, "<C-g>f", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

        vim.keymap.set("v", "<C-g>c", ":<C-u>'<,'>GpChatNew popup<cr>", keymapOptions("Visual Chat New"))
        vim.keymap.set("v", "<C-g>p", ":<C-u>'<,'>GpChatPaste popup<cr>", keymapOptions("Visual Chat Paste"))
        vim.keymap.set("v", "<C-g>t", ":<C-u>'<,'>GpChatToggle popup<cr>", keymapOptions("Visual Toggle Chat"))

        -- Prompt commands
        vim.keymap.set({ "n", "i" }, "<C-g>r", "<cmd>GpRewrite<cr>", keymapOptions("Inline Rewrite"))
        vim.keymap.set({ "n", "i" }, "<C-g>a", "<cmd>GpAppend<cr>", keymapOptions("Append (after)"))
        vim.keymap.set({ "n", "i" }, "<C-g>b", "<cmd>GpPrepend<cr>", keymapOptions("Prepend (before)"))

        vim.keymap.set("v", "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
        vim.keymap.set("v", "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
        vim.keymap.set("v", "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions("Visual Prepend (before)"))
        vim.keymap.set("v", "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("Implement selection"))

        vim.keymap.set({ "n", "i" }, "<C-g>gp", "<cmd>GpPopup<cr>", keymapOptions("Rewrite but in a popup window"))

        vim.keymap.set("v", "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions("Visual Popup"))

        vim.keymap.set({ "n", "i", "v", "x" }, "<C-g>s", "<cmd>GpStop<cr>", keymapOptions("Stop"))
        vim.keymap.set({ "n", "i", "v", "x" }, "<C-g>n", "<cmd>GpNextAgent<cr>", keymapOptions("Next Agent"))
    end,
}
