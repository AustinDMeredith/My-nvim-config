local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = ok
  and cmp_nvim_lsp.default_capabilities()
  or vim.lsp.protocol.make_client_capabilities()

---@type vim.lsp.Config
return {
  cmd = { 'perlnavigator', '--stdio' },
  filetypes = { 'perl' },
  root_markers = { '.git' },
  capabilities = capabilities,
}
