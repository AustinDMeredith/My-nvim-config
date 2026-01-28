return { 
  "nvim-treesitter/nvim-treesitter", 
  build = ":TSUpdate", 
  config = function ()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "bash", "python", "javascript", "json", "yaml", "markdown", "cpp", "java" },
      highlight = { enable = true },
      indent = { enable = true },
    })
    end
  }
