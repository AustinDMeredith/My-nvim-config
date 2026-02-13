local function set_float_hl()
  -- Core float highlight groups (used by LSP hover + many popups)
  vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })  -- slightly darker than background
  vim.api.nvim_set_hl(0, "FloatBorder", { link = "WinSeparator" })
  vim.api.nvim_set_hl(0, "FloatTitle", { link = "Title" })

  -- Noice-specific groups (covers Noice hover/cmdline/popup styles)
  pcall(vim.api.nvim_set_hl, 0, "NoicePopup", { link = "NormalFloat" })
  pcall(vim.api.nvim_set_hl, 0, "NoicePopupBorder", { link = "FloatBorder" })
  pcall(vim.api.nvim_set_hl, 0, "NoiceLspHover", { link = "NormalFloat" })
  pcall(vim.api.nvim_set_hl, 0, "NoiceLspHoverBorder", { link = "FloatBorder" })
end

-- Run once on startup (scheduled so it happens after UI is ready)
vim.schedule(set_float_hl)

-- Re-run any time the colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.schedule(set_float_hl)
  end,
})
