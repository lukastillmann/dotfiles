-----------------------------------------------------------
-- null-ls configuration file
-----------------------------------------------------------

-- Plugin null-ls
-- https://github.com/jose-elias-alvarez/null-ls.nvim/

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local nls = require("null-ls")

local formatting = nls.builtins.formatting
local diagnostics = nls.builtins.diagnostics
local code_actions = nls.builtins.code_actions

nls.setup({
    cmd = { "nvim" },
    --debug = true,
    sources = {

        -----------------
        -- FORMATTING --
        -----------------

        formatting.prettierd,
        -- formatting.prettier_d_slim,
        --formatting.eslint_d,
        --formatting.stylua,
        --formatting.lua_format,
        formatting.jq,
        formatting.json_tool,
        -- formatting.yamlfmt,              -- yaml

        -----------------
        -- Diagnostics --
        -----------------

        -- diagnostics.gitlint,
        --diagnostics.stylelint,
        --diagnostics.tsc,

        -----------------
        -- Code Actions --
        -----------------

        --code_actions.eslint_d,
        -- code_actions.gitsigns            -- Injects code actions for Git operations at the current cursor position

    },
})
