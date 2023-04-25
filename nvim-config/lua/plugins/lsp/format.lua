local M = {}

M.autoformat = true

function M.toggle()
	M.autoformat = not M.autoformat
	vim.notify(M.autoformat and "Enabled format on save" or "Disabled format on save")
end

function M.format(server)
	local buf = vim.api.nvim_get_current_buf()
	local ft = vim.bo[buf].filetype
	local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

	-- do not let tsserver or volar do the formatting, it does not respect
	-- .prettierrc settings
	if server and (server.name == "tsserver" or server.name == "volar") then
		vim.cmd("EslintFixAll")
	else
		vim.lsp.buf.format({
			bufnr = buf,
			filter = function(client)
				if have_nls then
					return client.name == "null-ls"
				end
				-- do not let volar do the formatting, it does not respect
				-- .prettierrc settings
				return client.name ~= "null-ls" and client.name ~= "volar" and client.name ~= "tsserver"
			end,
		})
	end
end

function M.on_attach(client, buf)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
			buffer = buf,
			callback = function()
				if M.autoformat then
					M.format(client)
				end
			end,
		})
	end
end

return M
