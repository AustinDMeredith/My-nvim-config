return {
    "sainnhe/gruvbox-material",
    enabled = true,
    priority = 1000,
    config = function()
        vim.g.gruvbox_material_transparent_background = 1
        vim.g.gruvbox_material_foreground = "mix"
        vim.g.gruvbox_material_background = "hard"
        vim.g.gruvbox_material_ui_contrast = "high"
        vim.g.gruvbox_material_float_style = "bright"
        vim.g.gruvbox_material_statusline_style = "material"
        vim.g.gruvbox_material_cursor = "auto"
        vim.cmd.colorscheme("gruvbox-material")


        local function set_float_hl()
          -- Make hover/doc popups match your theme
          vim.api.nvim_set_hl(0, "FloatBorder", { link = "WinSeparator" })
          vim.api.nvim_set_hl(0, "FloatTitle", { link = "Title" })
        end

        -- Apply immediately
        set_float_hl()

        -- Reapply if colorscheme changes
        vim.api.nvim_create_autocmd("ColorScheme", {
          callback = set_float_hl,
        })
    end,
}
