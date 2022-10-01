-----------------------------------------------------------
-- Handler setup for lsp-config
-----------------------------------------------------------
local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- if not status_cmp_ok then
--  return
-- end

M.capabilities.textDocument.completion.completionItem.snippetSupport = true
-- M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.setup = function()

    local config = {
        -- disable virtual text
        virtual_lines = false,
        virtual_text = false,
        -- virtual_text = {
        --   -- spacing = 7,
        --   -- update_in_insert = false,
        --   -- severity_sort = true,
        --   -- prefix = "<-",
        --   prefix = " ●",
        --   source = "if_many", -- Or "always"
        --   -- format = function(diag)
        --   --   return diag.message .. "blah"
        --   -- end,
        -- },

        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            -- border = {"▄","▄","▄","█","▀","▀","▀","█"},
            source = "if_many", -- Or "always"
            header = "",
            prefix = ""
            -- width = 40,
        }
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                                                 vim.lsp.handlers.hover, {
            border = "rounded"
            -- width = 60,
            -- height = 30,
        })

    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded"
            -- width = 60,
            -- height = 30,
        })
end

local function highlight_references(client)
    -- Highlighting references
    if client.server_capabilities.document_highlight then
        vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
    end

end

M.on_attach = function(client, bufnr)

    require("../../core/keymaps").lsp_keymaps(bufnr)

    highlight_references(client)
    --
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    if client.name == "tsserver" then
        require("lsp-inlayhints").on_attach(client, bufnr)
        -- enable format_on_save for all javascript files
        -- M.enable_format_on_save()
    end
end

function M.enable_format_on_save()
    vim.cmd [[
    augroup format_on_save
      autocmd!
      autocmd BufWritePre * lua require("plugins.lsp.handlers").format()
    augroup end
  ]]
    vim.notify "Enabled format on save"
end

function M.disable_format_on_save()
    M.remove_augroup "format_on_save"
    vim.notify "Disabled format on save"
end

function M.toggle_format_on_save()
    if vim.fn.exists "#format_on_save#BufWritePre" == 0 then
        M.enable_format_on_save()
    else
        M.disable_format_on_save()
    end
end

function M.remove_augroup(name)
    if vim.fn.exists("#" .. name) == 1 then vim.cmd("au! " .. name) end
end

-- do not let volar or tsserver do the formatting, it does not respect .prettierrc settings
function M.format(payload)
    vim.lsp.buf.format({
        filter = function(client)
            return client.name ~= "tsserver" and client.name ~=  "volar"
        end
    })
end

-- register LspToggleAutoFormat to toggle format_on_save
vim.cmd [[ command! LspToggleAutoFormat execute 'lua require("plugins.lsp.handlers").toggle_format_on_save()' ]]

-- register LspFormat command to format
vim.api.nvim_create_user_command("LspFormat", M.format, {
    nargs = 0,
    desc = "Format Code"
})

return M
