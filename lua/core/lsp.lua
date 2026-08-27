-- Handle jdt:// URIs from jdtls so gd opens library source
vim.lsp.config("jdtls", {
  handlers = {
    ["workspace/executeCommand"] = function() end,
  },
})

-- Register jdt URI handler
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "jdtls" then
      vim.lsp.commands["java.apply.workspaceEdit"] = function(command)
        require("jdtls").apply_workspace_edit(command.arguments[1])
      end
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "jdt://*",
  callback = function(args)
    require("jdtls").open_classfile(args.match)
  end,
})

-- Server install + enable is handled by mason-lspconfig (see plugins/mason.lua),
-- which installs the binaries via mason and calls vim.lsp.enable() for them.

vim.diagnostic.config({
    -- virtual_lines = true,
    virtual_text = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})
