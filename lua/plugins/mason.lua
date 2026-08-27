return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      -- Keep this in sync with the servers this config actually uses
      -- (see lsp/*.lua for their native vim.lsp.config definitions).
      ensure_installed = { "clangd", "lua_ls", "pyright", "ts_ls", "perlnavigator" },
    },
  },
}
