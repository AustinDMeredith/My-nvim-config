local function get_hl(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end

local function set_float_hl()

  local error_fg  = get_hl("DiagnosticError").fg
  local warn_fg   = get_hl("DiagnosticWarn").fg
  local info_fg   = get_hl("DiagnosticInfo").fg
  local hint_fg   = get_hl("DiagnosticHint").fg
  local normal_fg = get_hl("Normal").fg
  local keyword   = get_hl("Keyword").fg
  local string_fg = get_hl("String").fg

  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = error_fg, bg = "none" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  { fg = warn_fg,  bg = "none" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  { fg = info_fg,  bg = "none" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  { fg = hint_fg,  bg = "none" })

  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = error_fg, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  { sp = warn_fg,  undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",  { sp = info_fg,  undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",  { sp = hint_fg,  undercurl = true })

  vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { fg = keyword, bold = true, undercurl = true })

  vim.api.nvim_set_hl(0, "TelescopeNormal",         { fg = normal_fg, bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopeMatching",       { fg = string_fg, bold = true })
  vim.api.nvim_set_hl(0, "TelescopeSelection",      { fg = normal_fg, bold = true })
  vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = error_fg })
  vim.api.nvim_set_hl(0, "TelescopePromptPrefix",   { fg = error_fg })

  -- core float highlight groups (used by lsp hover + many popups)
  vim.api.nvim_set_hl(0, "normalfloat", { link = "normal" })  -- slightly darker than background
  vim.api.nvim_set_hl(0, "floatborder", { link = "winseparator" })
  vim.api.nvim_set_hl(0, "floattitle", { link = "title" })
  vim.api.nvim_set_hl(0, "pmenu", { link = "normalfloat" })
  vim.api.nvim_set_hl(0, "pmenusel", { link = "pmenusel" })  -- keep selection visible
  vim.api.nvim_set_hl(0, "pmenuborder", { link = "floatborder" })
  vim.api.nvim_set_hl(0, "pmenusbar", { link = "floatborder" })
  vim.api.nvim_set_hl(0, "pmenuthumb", { link = "visual" })

  -- noice-specific groups (covers noice hover/cmdline/popup styles)
  pcall(vim.api.nvim_set_hl, 0, "noicepopup", { link = "normalfloat" })
  pcall(vim.api.nvim_set_hl, 0, "noicepopupborder", { link = "floatborder" })
  pcall(vim.api.nvim_set_hl, 0, "noicelsphover", { link = "normalfloat" })
  pcall(vim.api.nvim_set_hl, 0, "noicelsphoverborder", { link = "floatborder" })
end

-- run once on startup (scheduled so it happens after ui is ready)
vim.schedule(set_float_hl)

-- re-run any time the colorscheme changes
vim.api.nvim_create_autocmd("colorscheme", {
  callback = function()
    vim.schedule(set_float_hl)
  end,
})
