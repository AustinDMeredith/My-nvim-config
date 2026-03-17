return {
  { "sainnhe/gruvbox-material", lazy = true },
  { "folke/tokyonight.nvim", lazy = true },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "marko-cerovac/material.nvim", lazy = true },
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "EdenEast/nightfox.nvim", lazy = true },
  { "shaunsingh/nord.nvim", lazy = true },
  { "sainnhe/everforest", lazy = true },
  { "sainnhe/edge", lazy = true },
  { "savq/melange-nvim", lazy = true },
  { "projekt0n/github-nvim-theme", lazy = true },

  {
    "zaldih/themery.nvim",
    priority = 999,
    config = function()
      require("themery").setup({
        themes = {
          {
            name = "Gruvbox Material",
            colorscheme = "gruvbox-material",
            before = [[
              vim.g.gruvbox_material_transparent_background = 1
              vim.g.gruvbox_material_foreground = "mix"
              vim.g.gruvbox_material_background = "hard"
              vim.g.gruvbox_material_ui_contrast = "high"
              vim.g.gruvbox_material_float_style = "bright"
              vim.g.gruvbox_material_statusline_style = "material"
              vim.g.gruvbox_material_cursor = "auto"
            ]],
          },
          { name = "Kanagawa Dragon", colorscheme = "kanagawa-dragon" },
          { name = "Everforest Hard", colorscheme = "everforest", before = [[
            vim.g.everforest_background = "hard"
            vim.g.everforest_transparent_background = 1
          ]] },
          { name = "Melange", colorscheme = "melange" },
          { name = "Edge", colorscheme = "edge" },
          { name = "Tokyo Night", colorscheme = "tokyonight" },
          { name = "Tokyo Night Moon", colorscheme = "tokyonight-moon" },
          { name = "Catppuccin Mocha", colorscheme = "catppuccin-mocha" },
          { name = "Catppuccin Macchiato", colorscheme = "catppuccin-macchiato" },
          {
            name = "Material Palenight",
            colorscheme = "material-palenight",
            before = [[ vim.g.material_style = "palenight" ]],
          },
          { name = "Rose Pine Moon", colorscheme = "rose-pine-moon" },
          { name = "Nordfox", colorscheme = "nordfox" },
          { name = "Nightfox", colorscheme = "nightfox" },
          { name = "Nord", colorscheme = "nord" },
          { name = "GitHub Dimmed", colorscheme = "github_dark_dimmed" },
        },
        livePreview = true,
      })
    end,
  },
}
