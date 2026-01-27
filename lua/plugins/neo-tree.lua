return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    config = function ()
      require("neo-tree").setup({
        filesystem = {
            git_status = {
                symbols = {
                    -- Change type
                    added     = "✚",
                    modified  = "",
                    deleted   = "✖",
                    renamed   = "󰁕",

                    -- Status type
                    untracked = "",
                    ignored   = "",
                    unstaged  = "󰄱",
                    staged    = "",
                    conflict  = "",
                    },
                },
          },
      })
    end
}
