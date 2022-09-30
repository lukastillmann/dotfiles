local l_status_ok, lsp_lines = pcall(require, "lsp_lines")
if not l_status_ok then
  return
end

lsp_lines.setup()
