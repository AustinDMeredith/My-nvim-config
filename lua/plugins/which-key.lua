return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      preset = "modern",
    })

    -- Label your leader groups so they show nicely
    wk.add({
      { "<leader>f", group = "Find" },
      { "<leader>d", group = "Diagnostics" },
      { "<leader>t", group = "Toggle" },
    })
  end,
}
